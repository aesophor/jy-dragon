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

#define GETTER(name, ctype, luapush)                                                     \
    static int name(lua_State *L) {                                                      \
        ByteBuf    *b = check_buf(L, 1);                                                 \
        lua_Integer o = luaL_checkinteger(L, 2);                                         \
        ctype       v;                                                                   \
        memcpy(&v, at(L, b, o, sizeof(ctype)), sizeof(ctype));                           \
        luapush(L, (lua_Number)v);                                                       \
        return 1;                                                                        \
    }
#define SETTER(name, ctype)                                                              \
    static int name(lua_State *L) {                                                      \
        ByteBuf    *b = check_buf(L, 1);                                                 \
        lua_Integer o = luaL_checkinteger(L, 2);                                         \
        ctype       v = (ctype)luaL_checkinteger(L, 3);                                  \
        memcpy(at(L, b, o, sizeof(ctype)), &v, sizeof(ctype));                           \
        return 0;                                                                        \
    }

GETTER(l_get16, int16_t, lua_pushnumber)
GETTER(l_getu16, uint16_t, lua_pushnumber)
GETTER(l_get32, int32_t, lua_pushnumber)
SETTER(l_set16, int16_t)
SETTER(l_setu16, uint16_t)
SETTER(l_set32, int32_t)

/* Byte.getstr(buf, off, len) -> NUL-trimmed raw bytes (still Big5/GBK) */
static int l_getstr(lua_State *L) {
    ByteBuf    *b = check_buf(L, 1);
    lua_Integer o = luaL_checkinteger(L, 2);
    lua_Integer n = luaL_checkinteger(L, 3);
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
    lua_Integer o = luaL_checkinteger(L, 2);
    lua_Integer n = luaL_checkinteger(L, 3);
    size_t      sl;
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
