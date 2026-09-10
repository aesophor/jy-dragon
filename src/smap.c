/* Scene maps: the S (tile) and D (event) arrays.
 *
 * Layout derived from the shipped data and confirmed statistically:
 *
 *   S  (allsin.grp / save/s<N>.grp)
 *      one record per scene, 64*64 cells * 6 int16 layers = 49152 bytes,
 *      stored LAYER-MAJOR: s[scene][layer][y*W + x]
 *
 *   D  (alldef.grp / save/d<N>.grp)
 *      one record per scene, 200 entries * 11 int16 fields = 4400 bytes:
 *      d[scene][index*fields + field]
 *
 * The trailing `11` argument to LoadSMap is the D field count, and
 * 4400/200 = 22 bytes = 11 int16 confirms it.
 */
#include "engine.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

static int16_t *g_s, *g_d;
static int      g_scenes, g_w, g_h, g_layers = 6;
static int      g_dnum, g_dfields;
static size_t   g_s_bytes, g_d_bytes;
static char     g_s_path[512], g_d_path[512];

static int16_t *slurp(const char *path, size_t *out_bytes) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        jy_log("LoadSMap: cannot open %s", path);
        return NULL;
    }
    fseek(f, 0, SEEK_END);
    long n = ftell(f);
    fseek(f, 0, SEEK_SET);
    int16_t *p = (int16_t *)malloc((size_t)n);
    if (!p) {
        fclose(f);
        return NULL;
    }
    size_t got = fread(p, 1, (size_t)n, f);
    fclose(f);
    *out_bytes = got;
    return p;
}

bool jy_smap_load(const char *sfile, const char *dfile, int scenes, int w, int h,
                  int dnum, int dfields) {
    free(g_s);
    free(g_d);
    g_s       = slurp(sfile, &g_s_bytes);
    g_d       = slurp(dfile, &g_d_bytes);
    g_scenes  = scenes;
    g_w       = w;
    g_h       = h;
    g_dnum    = dnum;
    g_dfields = dfields;
    snprintf(g_s_path, sizeof(g_s_path), "%s", sfile);
    snprintf(g_d_path, sizeof(g_d_path), "%s", dfile);

    size_t srec = (size_t)w * h * g_layers * 2;
    size_t drec = (size_t)dnum * dfields * 2;
    jy_log("LoadSMap: %s (%zu B, %zu scenes) + %s (%zu B, %zu scenes)  "
           "%dx%d x%d layers, D %dx%d",
           sfile, g_s_bytes, srec ? g_s_bytes / srec : 0, dfile, g_d_bytes,
           drec ? g_d_bytes / drec : 0, w, h, g_layers, dnum, dfields);
    return g_s && g_d;
}

/* Write the payload, not however long the file we loaded happened to be.
 *
 * slurp() sizes g_?_bytes from the file on disk, and the game appends a
 * 12-byte-per-slot checksum table past the end of the D payload
 * (write_content at 602800 + 12*slot in jymain.lua's SaveRecord). Copying
 * that tail forward means a d-file can end up longer than its own field:
 * save to a lower slot than the one you loaded and the 12 bytes LoadRecord
 * reads back come out as the digits plus NUL padding, which byte10 expands
 * to "0"s and hzbj then rejects -- a correct checksum failing on the shape
 * of the file rather than its contents.
 *
 * The payload is a whole number of records and nothing else, so write
 * exactly that: SaveRecord re-appends this slot's checksum afterwards and
 * the file ends right after it, which is the shape read_files expects.
 * Clamped by what we actually hold, so a short read at load cannot make us
 * write past the buffer.
 */
static size_t payload_bytes(size_t have, size_t want) {
    return have < want ? have : want;
}

bool jy_smap_save(const char *sfile, const char *dfile) {
    bool   ok = true;
    size_t sn = payload_bytes(g_s_bytes, (size_t)g_scenes * g_w * g_h * g_layers * 2);
    size_t dn = payload_bytes(g_d_bytes, (size_t)g_scenes * g_dnum * g_dfields * 2);

    if (sn != g_s_bytes || dn != g_d_bytes)
        jy_log("SaveSMap: trimming to payload (S %zu->%zu, D %zu->%zu)", g_s_bytes, sn,
               g_d_bytes, dn);

    if (g_s) {
        FILE *f = fopen(sfile, "wb");
        if (f) {
            fwrite(g_s, 1, sn, f);
            fclose(f);
        } else {
            jy_log("SaveSMap: cannot write %s", sfile);
            ok = false;
        }
    }
    if (g_d) {
        FILE *f = fopen(dfile, "wb");
        if (f) {
            fwrite(g_d, 1, dn, f);
            fclose(f);
        } else {
            jy_log("SaveSMap: cannot write %s", dfile);
            ok = false;
        }
    }
    return ok;
}

/* Out-of-range reads return -1, which is the sentinel the scripts already
 * expect from the event layer ("no event here"). */
int jy_get_s(int scene, int x, int y, int layer) {
    if (!g_s || scene < 0 || x < 0 || y < 0 || layer < 0 || x >= g_w || y >= g_h ||
        layer >= g_layers)
        return -1;
    size_t idx =
        ((size_t)scene * g_layers + layer) * ((size_t)g_w * g_h) + (size_t)y * g_w + x;
    if ((idx + 1) * 2 > g_s_bytes) return -1;
    return g_s[idx];
}

void jy_set_s(int scene, int x, int y, int layer, int v) {
    if (!g_s || scene < 0 || x < 0 || y < 0 || layer < 0 || x >= g_w || y >= g_h ||
        layer >= g_layers)
        return;
    size_t idx =
        ((size_t)scene * g_layers + layer) * ((size_t)g_w * g_h) + (size_t)y * g_w + x;
    if ((idx + 1) * 2 > g_s_bytes) return;
    g_s[idx] = (int16_t)v;
}

int jy_get_d(int scene, int index, int field) {
    if (!g_d || scene < 0 || index < 0 || field < 0 || index >= g_dnum ||
        field >= g_dfields)
        return -1;
    size_t idx = ((size_t)scene * g_dnum + index) * (size_t)g_dfields + field;
    if ((idx + 1) * 2 > g_d_bytes) return -1;
    return g_d[idx];
}

void jy_set_d(int scene, int index, int field, int v) {
    if (!g_d || scene < 0 || index < 0 || field < 0 || index >= g_dnum ||
        field >= g_dfields)
        return;
    size_t idx = ((size_t)scene * g_dnum + index) * (size_t)g_dfields + field;
    if ((idx + 1) * 2 > g_d_bytes) return;
    g_d[idx] = (int16_t)v;
}
