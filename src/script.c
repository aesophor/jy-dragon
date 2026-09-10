/* Script loading, with UTF-8 source files.
 *
 * The scripts do their own byte arithmetic on CJK text, and all of it assumes
 * a two-byte encoding:
 *
 *   jymain.lua:6404  GenTalkString steps 2 bytes per wide char to wrap talk
 *                    text, and budgets each line as `2 * columns - 1` bytes
 *   jywar.lua:22041  string.sub(s, n*2 - 1, n*2) slices out the n-th character
 *   jymain.lua:3624  string.len(s) / 2 * font is how pixel widths are computed
 *                    -- some thirty sites do this, with /2 and /4 variants
 *   MyOEvent.lua:9491  string.byte(s, -1) > 127 tests for a trailing wide char
 *
 * A CJK character is 3 bytes in UTF-8, so none of that survives a naive
 * conversion: wrapping would slice characters in half and every centred label
 * would sit 1.5x too wide.
 *
 * So the split is: the *files* on disk are UTF-8, readable and editable in any
 * modern editor, and the engine transcodes each chunk to GBK before LuaJIT
 * sees it. The bytes the interpreter runs are byte-identical to the original
 * GBK sources, so none of the arithmetic above changes and there is nothing to
 * re-verify. JY_SCRIPT_DUMP=<dir> writes out what was handed to LuaJIT.
 *
 * Encoding is detected per file rather than assumed, so GBK and UTF-8 sources
 * can coexist: a file that is valid UTF-8 *and* contains a multi-byte sequence
 * is transcoded, anything else is passed through untouched. GBK text does not
 * survive UTF-8 validation in practice -- its trail bytes run 0x40-0xFE, and
 * the ones above 0xBF cannot be UTF-8 continuation bytes -- so the two are
 * distinguishable well before the end of any real script.
 */
#include "engine.h"
#include <iconv.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>

/* Is this valid UTF-8, and does it use anything beyond ASCII? */
static bool utf8_scan(const uint8_t *p, size_t n, bool *has_multibyte) {
    *has_multibyte = false;
    for (size_t i = 0; i < n;) {
        uint8_t c = p[i];
        int     extra;
        if (c < 0x80) {
            i++;
            continue;
        } else if ((c & 0xE0) == 0xC0) extra = 1;
        else if ((c & 0xF0) == 0xE0) extra = 2;
        else if ((c & 0xF8) == 0xF0) extra = 3;
        else return false; /* stray trail or 0xF8+ */
        if (i + extra >= n) return false;
        for (int k = 1; k <= extra; k++)
            if ((p[i + k] & 0xC0) != 0x80) return false;
        /* Reject over-long forms, which would make detection ambiguous. */
        if (extra == 1 && c < 0xC2) return false;
        *has_multibyte = true;
        i += extra + 1;
    }
    return true;
}

/* UTF-8 -> GBK. Returns a malloc'd buffer, or NULL after logging why not. */
static char *to_gbk(const char *path, const char *src, size_t slen, size_t *out_len) {
    iconv_t cd = iconv_open("GBK", "UTF-8");
    if (cd == (iconv_t)-1) {
        jy_log("script: iconv_open(GBK <- UTF-8) failed for %s", path);
        return NULL;
    }
    /* GBK is never longer than UTF-8 for the characters that exist in both
     * (3 bytes -> 2), but ASCII is 1:1, so the source length is a safe cap. */
    size_t cap = slen + 16;
    char  *out = (char *)malloc(cap);
    if (!out) {
        iconv_close(cd);
        return NULL;
    }

    char  *ip = (char *)src, *op = out;
    size_t il = slen, ol = cap;
    while (il) {
        if (iconv(cd, &ip, &il, &op, &ol) != (size_t)-1) break;
        if (errno == E2BIG) { /* cannot happen, but be safe */
            size_t used = (size_t)(op - out);
            cap *= 2;
            char *bigger = (char *)realloc(out, cap);
            if (!bigger) {
                free(out);
                iconv_close(cd);
                return NULL;
            }
            out = bigger;
            op  = out + used;
            ol  = cap - used;
            continue;
        }
        /* Unmappable or malformed: say exactly where, and refuse. Silently
         * substituting would corrupt a string literal the game compares
         * against Big5 data, which is far harder to track down later. */
        size_t at   = (size_t)(ip - src);
        int    line = 1;
        for (size_t i = 0; i < at; i++)
            if (src[i] == '\n') line++;
        jy_log("script: %s:%d has a character GBK cannot represent "
               "(byte %zu: %02X %02X %02X) -- %s",
               path, line, at, (uint8_t)ip[0], il > 1 ? (uint8_t)ip[1] : 0,
               il > 2 ? (uint8_t)ip[2] : 0,
               errno == EILSEQ ? "not in GBK" : "truncated sequence");
        free(out);
        iconv_close(cd);
        return NULL;
    }
    iconv_close(cd);
    *out_len = (size_t)(op - out);
    return out;
}

/* Read a script file, transcoding UTF-8 sources to GBK. */
char *jy_script_read(const char *path, size_t *out_len) {
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;
    fseek(f, 0, SEEK_END);
    long n = ftell(f);
    fseek(f, 0, SEEK_SET);
    if (n < 0) {
        fclose(f);
        return NULL;
    }
    char *raw = (char *)malloc((size_t)n + 1);
    if (!raw) {
        fclose(f);
        return NULL;
    }
    size_t got = fread(raw, 1, (size_t)n, f);
    fclose(f);
    raw[got] = '\0';

    /* A UTF-8 BOM is not part of the chunk; Lua would choke on it. */
    char  *body = raw;
    size_t blen = got;
    if (blen >= 3 && memcmp(body, "\xEF\xBB\xBF", 3) == 0) {
        body += 3;
        blen -= 3;
    }

    bool multibyte = false;
    if (utf8_scan((const uint8_t *)body, blen, &multibyte) && multibyte) {
        size_t glen = 0;
        char  *gbk  = to_gbk(path, body, blen, &glen);
        free(raw);
        if (!gbk) return NULL;
        *out_len = glen;
        return gbk;
    }
    if (body != raw) memmove(raw, body, blen + 1);
    *out_len = blen;
    return raw;
}

/* Load a script as a Lua chunk. Returns 0 on success with the chunk on the
 * stack, else a non-zero LUA_ERR* with the message on the stack. */
int jy_script_load(lua_State *L, const char *path) {
    size_t len = 0;
    char  *buf = jy_script_read(path, &len);
    if (!buf) {
        lua_pushfstring(L, "cannot read %s", path);
        return LUA_ERRFILE;
    }
    const char *dump = getenv("JY_SCRIPT_DUMP");
    if (dump) {
        const char *base = strrchr(path, '/');
        char        out[1024];
        snprintf(out, sizeof(out), "%s/%s", dump, base ? base + 1 : path);
        FILE *o = fopen(out, "wb");
        if (o) {
            fwrite(buf, 1, len, o);
            fclose(o);
            jy_log("script dump: %s", out);
        }
    }
    /* '@' makes LuaJIT report the chunk as a file, so tracebacks read the
     * same as they did under luaL_loadfile. */
    char chunkname[512];
    snprintf(chunkname, sizeof(chunkname), "@%s", path);
    int rc = luaL_loadbuffer(L, buf, len, chunkname);
    free(buf);
    return rc;
}

/* package.loaders[2] replacement: resolve a module against package.path and
 * load it through jy_script_load. Mirrors the stock searcher's contract --
 * return the chunk on success, or a string explaining each path it tried. */
static int l_searcher(lua_State *L) {
    const char *name = luaL_checkstring(L, 1);

    lua_getglobal(L, "package");
    lua_getfield(L, -1, "path");
    const char *path = lua_tostring(L, -1);
    if (!path) {
        lua_pushstring(L, "\n\tpackage.path is not a string");
        return 1;
    }

    /* Lua turns dots into directory separators before substituting. */
    char   mod[256];
    size_t mi = 0;
    for (const char *s = name; *s && mi + 1 < sizeof(mod); s++)
        mod[mi++] = (*s == '.') ? '/' : *s;
    mod[mi] = '\0';

    luaL_Buffer errs;
    luaL_buffinit(L, &errs);

    const char *p = path;
    while (*p) {
        const char *end  = strchr(p, ';');
        size_t      tlen = end ? (size_t)(end - p) : strlen(p);

        char   file[1024];
        size_t fi = 0;
        for (size_t i = 0; i < tlen && fi + mi + 1 < sizeof(file); i++) {
            if (p[i] == '?') {
                memcpy(file + fi, mod, mi);
                fi += mi;
            } else file[fi++] = p[i];
        }
        file[fi] = '\0';

        if (fi && access(file, R_OK) == 0) {
            if (jy_script_load(L, file) == 0) return 1; /* chunk */
            return luaL_error(L, "error loading module '%s' from '%s':\n\t%s", name, file,
                              lua_tostring(L, -1));
        }
        if (fi) {
            luaL_addstring(&errs, "\n\tno file '");
            luaL_addstring(&errs, file);
            luaL_addstring(&errs, "'");
        }
        if (!end) break;
        p = end + 1;
    }
    luaL_pushresult(&errs);
    return 1;
}

/* Take over the Lua-file searcher, leaving package.preload and the C loaders
 * where they are. */
void jy_script_install(lua_State *L) {
    lua_getglobal(L, "package");
    if (!lua_istable(L, -1)) {
        lua_pop(L, 1);
        return;
    }
    lua_getfield(L, -1, "loaders");
    if (!lua_istable(L, -1)) {
        lua_pop(L, 2);
        return;
    }
    lua_pushcfunction(L, l_searcher);
    lua_rawseti(L, -2, 2); /* [1] preload, [2] Lua files */
    lua_pop(L, 2);
}
