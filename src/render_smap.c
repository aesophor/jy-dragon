/* Isometric scene renderer -- ported from sub_404E30 (lib.DrawSMap).
 *
 * The scene is a diamond lattice centred on the player. For lattice offset
 * (i, j) from the player, the cell is (px+ox+i, py+oy+j) and its screen
 * position is
 *     sx = W/2 + XScale*(i - j)
 *     sy = H/2 + YScale*(i + j)
 *
 * Two passes, matching the original:
 *   1. ground  -- layer 0 sprite, drawn flat
 *   2. objects -- layer 1 and 2 sprites raised by the elevations in layers 4
 *      and 5; the layer-3 event index selects a sprite from D field 7; and the
 *      player sprite goes on the cell the camera is centred on.
 *
 * Pass 2 walks increasing depth (i+j) so nearer objects overdraw farther ones.
 */
#include "engine.h"

/* Sprite ids stored in the map are pre-doubled; jy_pic_draw halves them. */
#define SMAP_SLOT 0
#define R 42 /* lattice radius: covers 1220x700 at 18/9 scale */

static int g_xscale = 18, g_yscale = 9;

void jy_smap_set_scale(int xs, int ys) {
    if (xs > 0) g_xscale = xs;
    if (ys > 0) g_yscale = ys;
}

void jy_draw_smap(int scene, int px, int py, int ox, int oy, int mypic) {
    const int cx = g_e.w / 2, cy = g_e.h / 2;

    /* Cls() calls this as a full background redraw with no fill of its own, but
     * a 64x64 scene does not always cover the window: DrawSMap() in jymain.lua
     * clamps the camera to cells 12..45, so at the clamp edge the top band of
     * the screen gets no tiles (134px at 700 tall; it was a ~24px sliver at the
     * original 640x480). Anything drawn there previously would survive the
     * redraw -- which is what left dialogue borders on screen. Clear first. */
    jy_fill_rect(g_e.clip.x, g_e.clip.y, g_e.clip.x + g_e.clip.w - 1,
                 g_e.clip.y + g_e.clip.h - 1, 0x000000, 255);

    /* pass 1: ground. Tiles tessellate, so draw order does not matter. */
    for (int i = -R; i <= R; i++) {
        for (int j = -R; j <= R; j++) {
            int sx = cx + g_xscale * (i - j);
            int sy = cy + g_yscale * (i + j);
            if (sx < -64 || sx > g_e.w + 64 || sy < -64 || sy > g_e.h + 64) continue;
            int mx = px + ox + i, my = py + oy + j;
            int id = jy_get_s(scene, mx, my, 0);
            if (id > 0) jy_pic_draw(SMAP_SLOT, id, sx, sy, 0, 0);
        }
    }

    /* pass 2: objects, back to front by depth = i + j */
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

            int mx = px + ox + i, my = py + oy + j;
            int obj1  = jy_get_s(scene, mx, my, 1);
            int obj2  = jy_get_s(scene, mx, my, 2);
            int evt   = jy_get_s(scene, mx, my, 3);
            int lift1 = jy_get_s(scene, mx, my, 4);
            int lift2 = jy_get_s(scene, mx, my, 5);
            if (lift1 < 0) lift1 = 0;
            if (lift2 < 0) lift2 = 0;

            if (obj1 > 0) jy_pic_draw(SMAP_SLOT, obj1, sx, sy - lift1, 0, 0);
            if (obj2 > 0) jy_pic_draw(SMAP_SLOT, obj2, sx, sy - lift2, 0, 0);
            if (evt >= 0) {
                int eid = jy_get_d(scene, evt, 7); /* D field 7 = sprite id */
                if (eid > 0) jy_pic_draw(SMAP_SLOT, eid, sx, sy - lift1, 0, 0);
            }
            /* the player stands on the cell the camera is centred on */
            if (i == -ox && j == -oy && mypic > 0)
                jy_pic_draw(SMAP_SLOT, 2 * mypic, sx, sy - lift1, 0, 0);
        }
    }
}
