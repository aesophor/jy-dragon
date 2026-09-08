#!/usr/bin/env python3
"""Regenerate src/s2t_table.h -- the Simplified -> Traditional display map.

    python3 -m venv /tmp/v && /tmp/v/bin/pip install opencc-python-reimplemented
    /tmp/v/bin/python tools/gen_s2t.py > src/s2t_table.h

Uses OpenCC's **s2tw** (Taiwan standard) rather than plain s2t: s2t picks the
archaic 喫 for 吃 and prefers 衆/裏 where Taiwan uses 眾/裡.

Only one-to-one BMP mappings are emitted. OpenCC also knows phrase-level
substitutions (软件 -> 軟體), but those change the character count, and the
game computes pixel widths from string byte lengths -- a 1:1 map guarantees
conversion cannot move any text. The 28 mappings whose target sits outside the
BMP are dropped too; they are obscure Ext-A characters that neither GBK nor
Big5 can represent, so they never reach the renderer.
"""
import sys

try:
    import opencc
except ImportError:
    sys.exit("need opencc-python-reimplemented (see the docstring)")

HEADER = """/* Simplified -> Traditional character map, generated -- do not hand-edit.
 *
 *   tools/gen_s2t.py   (OpenCC s2tw, the Taiwan standard variant)
 *
 * Sorted by the Simplified code point so text.c can binary-search it. Only
 * one-to-one BMP mappings are included: OpenCC also knows phrase-level
 * substitutions (软件 -> 軟體), but those change the character count, and the
 * scripts compute pixel widths from string byte lengths. Keeping it 1:1 means
 * conversion cannot move any text.
 */
#ifndef JY_S2T_TABLE_H
#define JY_S2T_TABLE_H

#include <stdint.h>

typedef struct { uint16_t s, t; } S2TPair;

// clang-format off
static const S2TPair jy_s2t[] = {
"""

# CJK Ext-A, the unified block, and the compatibility ideographs.
RANGES = [(0x3400, 0x4DC0), (0x4E00, 0xA000), (0xF900, 0xFB00)]


def main() -> int:
    convert = opencc.OpenCC("s2tw").convert
    pairs, skipped = [], 0
    for lo, hi in RANGES:
        for cp in range(lo, hi):
            src = chr(cp)
            dst = convert(src)
            if dst == src:
                continue
            if len(dst) != 1 or ord(dst) > 0xFFFF:
                skipped += 1
                continue
            pairs.append((cp, ord(dst)))
    pairs.sort()

    out = [HEADER]
    for i in range(0, len(pairs), 6):
        row = " ".join(f"{{0x{s:04X},0x{t:04X}}}," for s, t in pairs[i:i + 6])
        out.append("    " + row + "\n")
    out.append("};\n// clang-format on\n\n"
               "#define JY_S2T_COUNT (sizeof(jy_s2t) / sizeof(jy_s2t[0]))\n\n#endif\n")
    sys.stdout.write("".join(out))
    print(f"{len(pairs)} mappings, {skipped} skipped (non-BMP or multi-char)",
          file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
