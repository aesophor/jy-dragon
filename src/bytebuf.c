/* The 11-function `Byte` table.
 *
 * Semantics are known exactly from the game's own Lua:
 *   jymain.lua:GetDataFromStruct/SetDataFromStruct and readkdef.lua:ReadKDEF.
 * A Byte buffer is a flat byte array; all multi-byte access is little-endian.
 */
#include "engine.h"
#include <string.h>
#include <stdio.h>

#define BYTEBUF_MT "jy.bytebuf"

typedef struct {
    size_t   len;
    uint8_t *p;
} ByteBuf;

static ByteBuf *check_buf(lua_State *L, int idx) {
    ByteBuf *b = (ByteBuf *)lua_touserdata(L, idx);
    if (!b) luaL_error(L, "Byte: expected buffer at arg %d", idx);
    return b;
}

/* Bounds-check helper: the original engine trusts the scripts, but a bad
 * offset here would be an out-of-bounds read, so we fail loudly instead. */
static uint8_t *at(lua_State *L, ByteBuf *b, lua_Integer off, size_t need) {
    if (off < 0 || (size_t)off + need > b->len)
        luaL_error(L, "Byte: offset %d (+%d) out of range, buffer is %d bytes", (int)off,
                   (int)need, (int)b->len);
    return b->p + off;
}

/* Every numeric argument goes through the raw lua_tonumber in the original,
 * never luaL_checknumber: sub_403300 (set16/setu16) and sub_403490 (setstr)
 * both call lua_tonumber and use the result unchecked. lua_tonumber coerces a
 * numeric string and returns 0 for everything else -- without raising.
 *
 * The mod depends on that quiet zero. CC.Person_S.天赋 is declared as a
 * 16-bit field (offset 10, type 0) but jymain.lua:592 assigns it a talent
 * NAME out of ZJTF, so the original stores 0 and the UI reads the name from
 * ZJTF directly instead (jymain.lua:2557). Raising an error instead aborted
 * NewGame at the very end of the character-creation chain.
 *
 * The coercion is logged, capped, so these sites stay visible rather than
 * turning into silent zeroes nobody ever sees.
 */
#define COERCE_WARN_MAX 20
static int g_coerce_warns;

static lua_Number numarg(lua_State *L, int idx, const char *fn) {
    /* lua_isnumber is true for numeric strings too, so "7" does not warn. */
    if (lua_isnumber(L, idx)) return lua_tonumber(L, idx);
    if (g_coerce_warns < COERCE_WARN_MAX) {
        g_coerce_warns++;
        jy_log("Byte.%s: arg %d is a %s, not a number -- stored 0, as the original "
               "does%s",
               fn, idx, luaL_typename(L, idx),
               g_coerce_warns == COERCE_WARN_MAX ? " [further warnings suppressed]" : "");
    }
    return 0;
}

/* _ftol2_sse yields the x86 "integer indefinite" value for NaN and for
 * anything outside the range; guarding here keeps the cast out of UB. */
static int32_t to_i32(lua_Number n) {
    if (!(n >= -2147483648.0 && n <= 2147483647.0)) return INT32_MIN;
    return (int32_t)n;
}

static int l_create(lua_State *L) {
    lua_Integer n = luaL_checkinteger(L, 1);
    if (n < 0) n = 0;
    ByteBuf *b = (ByteBuf *)lua_newuserdata(L, sizeof(ByteBuf) + (size_t)n);
    b->len     = (size_t)n;
    b->p       = (uint8_t *)(b + 1);
    memset(b->p, 0, b->len);
    luaL_getmetatable(L, BYTEBUF_MT);
    lua_setmetatable(L, -2);
    return 1;
}

/* Byte.loadfile(buf, path, fileOffset, length) -> reads into buf at 0 */
static int l_loadfile(lua_State *L) {
    ByteBuf    *b    = check_buf(L, 1);
    const char *path = luaL_checkstring(L, 2);
    lua_Integer off  = luaL_optinteger(L, 3, 0);
    lua_Integer len  = luaL_optinteger(L, 4, (lua_Integer)b->len);

    if (len < 0 || (size_t)len > b->len) len = (lua_Integer)b->len;

    FILE *f = fopen(path, "rb");
    if (!f) {
        jy_log("Byte.loadfile: cannot open %s", path);
        lua_pushboolean(L, 0);
        return 1;
    }
    if (fseek(f, (long)off, SEEK_SET) != 0) {
        fclose(f);
        jy_log("Byte.loadfile: bad seek %ld in %s", (long)off, path);
        lua_pushboolean(L, 0);
        return 1;
    }
    size_t got = fread(b->p, 1, (size_t)len, f);
    fclose(f);
    if (got < (size_t)len) memset(b->p + got, 0, (size_t)len - got);
    lua_pushboolean(L, 1);
    return 1;
}

/* Byte.savefile(buf, path, fileOffset, length) -> writes buf into the file */
static int l_savefile(lua_State *L) {
    ByteBuf    *b    = check_buf(L, 1);
    const char *path = luaL_checkstring(L, 2);
    lua_Integer off  = luaL_optinteger(L, 3, 0);
    lua_Integer len  = luaL_optinteger(L, 4, (lua_Integer)b->len);

    if (len < 0 || (size_t)len > b->len) len = (lua_Integer)b->len;

    FILE *f = fopen(path, "r+b");
    if (!f) f = fopen(path, "w+b");
    if (!f) {
        jy_log("Byte.savefile: cannot open %s", path);
        lua_pushboolean(L, 0);
        return 1;
    }
    fseek(f, (long)off, SEEK_SET);
    size_t put = fwrite(b->p, 1, (size_t)len, f);
    fclose(f);
    lua_pushboolean(L, put == (size_t)len);
    return 1;
}

#define GETTER(name, ctype, luapush, fname)                                              \
    static int name(lua_State *L) {                                                      \
        ByteBuf    *b = check_buf(L, 1);                                                 \
        lua_Integer o = to_i32(numarg(L, 2, fname));                                     \
        ctype       v;                                                                   \
        memcpy(&v, at(L, b, o, sizeof(ctype)), sizeof(ctype));                           \
        luapush(L, (lua_Number)v);                                                       \
        return 1;                                                                        \
    }
#define SETTER(name, ctype, fname)                                                       \
    static int name(lua_State *L) {                                                      \
        ByteBuf    *b = check_buf(L, 1);                                                 \
        lua_Integer o = to_i32(numarg(L, 2, fname));                                     \
        ctype       v = (ctype)to_i32(numarg(L, 3, fname));                              \
        memcpy(at(L, b, o, sizeof(ctype)), &v, sizeof(ctype));                           \
        return 0;                                                                        \
    }

GETTER(l_get16, int16_t, lua_pushnumber, "get16")
GETTER(l_getu16, uint16_t, lua_pushnumber, "getu16")
GETTER(l_get32, int32_t, lua_pushnumber, "get32")
SETTER(l_set16, int16_t, "set16")
SETTER(l_setu16, uint16_t, "setu16")
SETTER(l_set32, int32_t, "set32")

/* Byte.getstr(buf, off, len) -> NUL-trimmed raw bytes (still Big5/GBK) */
static int l_getstr(lua_State *L) {
    ByteBuf    *b = check_buf(L, 1);
    lua_Integer o = to_i32(numarg(L, 2, "getstr"));
    lua_Integer n = to_i32(numarg(L, 3, "getstr"));
    if (n < 0) n = 0;
    const uint8_t *p    = at(L, b, o, (size_t)n);
    size_t         real = 0;
    while (real < (size_t)n && p[real]) real++;
    lua_pushlstring(L, (const char *)p, real);
    return 1;
}

/* Byte.setstr(buf, off, len, str) -> NUL-padded fixed field.
 * Note the argument order: the field width comes BEFORE the string
 * (see SetDataFromStruct in jymain.lua). */
static int l_setstr(lua_State *L) {
    ByteBuf    *b = check_buf(L, 1);
    lua_Integer o = to_i32(numarg(L, 2, "setstr"));
    lua_Integer n = to_i32(numarg(L, 3, "setstr"));
    size_t      sl;
    /* lua_tolstring in the original, which also coerces a number. It returns
     * NULL for anything else and the original then walks it -- luaL_checklstring
     * raises instead, which is the same for every input that is not a crash. */
    const char *s = luaL_checklstring(L, 4, &sl);
    if (n < 0) n = 0;
    uint8_t *dst  = at(L, b, o, (size_t)n);
    size_t   copy = sl < (size_t)n ? sl : (size_t)n;
    memcpy(dst, s, copy);
    if (copy < (size_t)n) memset(dst + copy, 0, (size_t)n - copy);
    return 0;
}

static const luaL_Reg BYTE_FUNCS[] = {
    {"create", l_create}, {"loadfile", l_loadfile}, {"savefile", l_savefile},
    {"get16", l_get16},   {"set16", l_set16},       {"getu16", l_getu16},
    {"setu16", l_setu16}, {"get32", l_get32},       {"set32", l_set32},
    {"getstr", l_getstr}, {"setstr", l_setstr},     {NULL, NULL}};

void jy_open_byte(lua_State *L) {
    luaL_newmetatable(L, BYTEBUF_MT);
    lua_pop(L, 1);
    lua_newtable(L);
    luaL_register(L, NULL, BYTE_FUNCS);
    lua_setglobal(L, "Byte");
}
