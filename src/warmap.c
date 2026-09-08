/* Battle map (战斗地图) -- ported from:
 *   JY_LoadWarMap   sub_405280
 *   JY_GetWarMap    sub_4053E0
 *   JY_SetWarMap    sub_405450-ish (same indexing)
 *   JY_CleanWarMap  sub_4054B0
 *   JY_DrawWarMap   sub_405500
 *
 * Storage: 7 layers of w*h int16, indexed layer-major exactly like the scene
 * maps:  buf[layer*w*h + y*w + x].
 *
 * Only layers 0 and 1 come from warfld.grp -- a record is 16384 bytes =
 * 64*64*2*2, i.e. two int16 planes. The other five are runtime combat state
 * that the scripts fill via SetWarMap/CleanWarMap:
 *
 *   0  ground tile sprite
 *   1  scenery sprite
 *   2  occupying team/unit id   (>= 0 means occupied; also picks a sprite slot)
 *   3  movement-range cost      (< 128 means reachable)
 *   4  per-cell flag            (mode 3 dims cells with value <= 1)
 *   5  unit sprite id
 *   6  marker type 1..4         (coloured overlay)
 *
 * Elevation comes from the *scene* map's layer 4 (GetS(scene, x, y, 4)) when a
 * scene id is supplied, so battle tiles line up with the terrain underneath.
 */
#include "engine.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define WAR_SLOT 0 /* ground/scenery come from pic slot 0 */
#define MAX_LAYER 7
#define R 40

static int16_t *g_war;
static int      g_w, g_h, g_layers;
static int      g_xscale = 18, g_yscale = 9;

void jy_warmap_set_scale(int xs, int ys) {
    if (xs > 0) g_xscale = xs;
    if (ys > 0) g_yscale = ys;
}

bool jy_warmap_load(const char *idxp, const char *grpp, int map_index, int layers, int w,
                    int h) {
    free(g_war);
    g_war    = NULL;
    g_w      = w;
    g_h      = h;
    g_layers = layers > 0 && layers <= MAX_LAYER ? layers : MAX_LAYER;

    size_t cells = (size_t)w * h;
    g_war        = (int16_t *)calloc(cells * g_layers, sizeof(int16_t));
    if (!g_war) {
        jy_log("LoadWarMap: out of memory");
        return false;
    }

    /* The .idx gives the record offset; index 0 means "start of file". */
    uint32_t off = 0;
    if (map_index) {
        FILE *f = fopen(idxp, "rb");
        if (!f) {
            jy_log("LoadWarMap: cannot open %s", idxp);
            return false;
        }
        if (fseek(f, 4L * map_index - 4, SEEK_SET) == 0)
            if (fread(&off, 4, 1, f) != 1) off = 0;
        fclose(f);
    }

    FILE *f = fopen(grpp, "rb");
    if (!f) {
        jy_log("LoadWarMap: cannot open %s", grpp);
        return false;
    }
    fseek(f, (long)off, SEEK_SET);
    /* two planes only: 2*w*h int16 */
    size_t got = fread(g_war, 2, cells * 2, f);
    fclose(f);
    jy_log("LoadWarMap: map %d @%u, %dx%d x%d layers (read %zu of %zu int16)", map_index,
           off, w, h, g_layers, got, cells * 2);
    return true;
}

int jy_get_warmap(int x, int y, int layer) {
    if (!g_war || x < 0 || y < 0 || x >= g_w || y >= g_h || layer < 0 ||
        layer >= g_layers)
        return 0;
    return g_war[(size_t)layer * g_w * g_h + (size_t)y * g_w + x];
}

void jy_set_warmap(int x, int y, int layer, int v) {
    if (!g_war || x < 0 || y < 0 || x >= g_w || y >= g_h || layer < 0 ||
        layer >= g_layers)
        return;
    g_war[(size_t)layer * g_w * g_h + (size_t)y * g_w + x] = (int16_t)v;
}

void jy_clean_warmap(int layer, int value) {
    if (!g_war || layer < 0 || layer >= g_layers) return;
    int16_t *p = g_war + (size_t)layer * g_w * g_h;
    for (size_t i = 0, n = (size_t)g_w * g_h; i < n; i++) p[i] = (int16_t)value;
}

/* Marker colours for layer 6, values 1..4 (from the switch in sub_405500). */
static int marker_tint(int kind) {
    switch (kind) {
    case 1: return 380944;   /* 0x05D010 */
    case 2: return 13967888; /* 0xD52BD0 */
    case 3: return 240;      /* 0x0000F0 */
    case 4: return 10490016; /* 0xA00CE0 */
    default: return 0xFFFFFF;
    }
}

void jy_draw_warmap(int mode, int camx, int camy, int a4, int a5, int anim_id, int scene,
                    int anim_slot, int ax, int ay) {
    const int cx = g_e.w / 2, cy = g_e.h / 2;

    /* Background redraw: start from a known state (see jy_draw_smap). */
    jy_fill_rect(g_e.clip.x, g_e.clip.y, g_e.clip.x + g_e.clip.w - 1,
                 g_e.clip.y + g_e.clip.h - 1, 0x000000, 255);

/* elevation of a cell, from the scene map underneath */
#define ELEV(mx, my) (scene >= 0 ? jy_get_s(scene, (mx), (my), 4) : 0)

    /* pass 1: ground tiles and coloured markers */
    for (int i = -R; i <= R; i++) {
        for (int j = -R; j <= R; j++) {
            int sx = cx + g_xscale * (i - j);
            int sy = cy + g_yscale * (i + j);
            if (sx < -64 || sx > g_e.w + 64 || sy < -64 || sy > g_e.h + 64) continue;
            int mx = camx + i, my = camy + j;
            if (mx < 0 || my < 0 || mx >= g_w || my >= g_h) continue;

            int ground = jy_get_warmap(mx, my, 0);
            if (ground > 0) jy_pic_draw(WAR_SLOT, ground, sx, sy, 0, 0);

            int marker = jy_get_warmap(mx, my, 6);
            if (marker > 0) {
                int e = ELEV(mx, my);
                jy_pic_draw_tinted(WAR_SLOT, 0, sx, sy - e, 18, 192, marker_tint(marker));
            }
        }
    }

    /* pass 2: movement / attack range shading, only in modes 1 and 2 */
    if (mode == 1 || mode == 2) {
        for (int i = -R; i <= R; i++) {
            for (int j = -R; j <= R; j++) {
                int sx = cx + g_xscale * (i - j);
                int sy = cy + g_yscale * (i + j);
                if (sx < -64 || sx > g_e.w + 64 || sy < -64 || sy > g_e.h + 64) continue;
                int mx = camx + i, my = camy + j;
                if (mx < 0 || my < 0 || mx >= g_w || my >= g_h) continue;
                if (jy_get_warmap(mx, my, 3) >= 128) continue; /* unreachable */

                int flags = (mode == 1) ? 6 : 10;
                int alpha = (mx == a4 && my == a5) ? 128 : 64;
                jy_pic_draw(WAR_SLOT, 0, sx, sy - ELEV(mx, my), flags, alpha);
            }
        }
    }

    /* pass 3: scenery and units, back to front by depth */
    for (int depth = -2 * R; depth <= 2 * R; depth++) {
        int lo = depth - R;
        if (lo < -R) lo = -R;
        int hi = depth + R;
        if (hi > R) hi = R;
        for (int i = lo; i <= hi; i++) {
            int j = depth - i;
            if (j < -R || j > R) continue;
            int sx = cx + g_xscale * (i - j);
            int sy = cy + g_yscale * (i + j);
            if (sx < -256 || sx > g_e.w + 256 || sy < -256 || sy > g_e.h + 256) continue;
            int mx = camx + i, my = camy + j;
            if (mx < 0 || my < 0 || mx >= g_w || my >= g_h) continue;

            int e = ELEV(mx, my);

            int scenery = jy_get_warmap(mx, my, 1);
            if (scenery > 0) jy_pic_draw(WAR_SLOT, scenery, sx, sy - e, 0, 0);

            int team = jy_get_warmap(mx, my, 2);
            int unit = jy_get_warmap(mx, my, 5);
            if (team >= 0 && unit >= 0) {
                switch (mode) {
                case 3: {
                    /* dim units that have already acted */
                    int spent = jy_get_warmap(mx, my, 4) <= 1;
                    jy_pic_draw(WAR_SLOT, unit, sx, sy - e, spent ? 0 : 6,
                                spent ? 0 : 255);
                    break;
                }
                case 4:
                    if (mx == camx && my == camy && a5)
                        jy_pic_draw(a5, a4, sx, sy - e, 0, 0);
                    else if (unit >= 1000) jy_pic_draw(WAR_SLOT, unit, sx, sy - e, 0, 0);
                    else /* fight%03d archives are loaded into slots team+4 */
                        jy_pic_draw(team + 4, unit, sx, sy - e, 0, 0);
                    break;
                default: jy_pic_draw(WAR_SLOT, unit, sx, sy - e, 0, 0); break;
                }
            }

            /* animation overlay: a specific cell if (ax,ay) given, else any
             * cell whose layer-4 flag is set */
            if (anim_id >= 0 && anim_slot >= 0) {
                bool here = (ax >= 0 && ay >= 0) ? (ax == mx && ay == my)
                                                 : (jy_get_warmap(mx, my, 4) > 0);
                if (here) jy_pic_draw(anim_slot, anim_id, sx, sy - e, 0, 0);
            }
        }
    }
#undef ELEV
}
