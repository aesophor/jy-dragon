#!/usr/bin/env python3
"""Re-encode the game's Lua scripts between GBK and UTF-8.

The engine detects either encoding per file and transcodes UTF-8 sources to
GBK before LuaJIT sees them (src/script.c), so this is purely for the benefit
of your editor -- the game behaves identically either way.

    tools/to_utf8.py game/script game/CONFIG.lua        # GBK  -> UTF-8
    tools/to_utf8.py --to-gbk game/script               # UTF-8 -> GBK

Files already in the target encoding, and pure-ASCII files, are left alone.
Nothing is written unless the round-trip is verified lossless first.
"""
import argparse
import pathlib
import sys


def sniff(raw: bytes) -> str:
    """'ascii', 'utf-8' or 'gbk' -- what this file appears to hold."""
    if not any(b >= 0x80 for b in raw):
        return "ascii"
    try:
        raw.decode("utf-8")
        return "utf-8"
    except UnicodeDecodeError:
        return "gbk"


def convert(path: pathlib.Path, target: str) -> str:
    raw = path.read_bytes()
    found = sniff(raw)
    if found == "ascii":
        return "ascii, unchanged"
    if found == target:
        return f"already {target}, unchanged"

    source = "gbk" if target == "utf-8" else "utf-8"
    try:
        text = raw.decode(source)
    except UnicodeDecodeError as e:
        return f"NOT VALID {source.upper()}: {e}"
    try:
        out = text.encode(target)
    except UnicodeEncodeError as e:
        return f"cannot be represented in {target.upper()}: {e}"
    if out.decode(target).encode(source) != raw:
        return f"REFUSED: {source} -> {target} does not round-trip"

    path.write_bytes(out)
    return f"{source} -> {target} ({len(raw)} -> {len(out)} bytes)"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("paths", nargs="+", help="Lua files, or directories of them")
    ap.add_argument("--to-gbk", action="store_true", help="convert back to GBK")
    args = ap.parse_args()
    target = "gbk" if args.to_gbk else "utf-8"

    files: list[pathlib.Path] = []
    for p in map(pathlib.Path, args.paths):
        if p.is_dir():
            files += sorted(p.glob("*.lua"))
        elif p.is_file():
            files.append(p)
        else:
            print(f"no such path: {p}", file=sys.stderr)
            return 1

    problems = 0
    for f in files:
        result = convert(f, target)
        if result.startswith(("NOT VALID", "REFUSED", "cannot be")):
            problems += 1
        print(f"{str(f):40} {result}")
    if problems:
        print(f"\n{problems} file(s) left untouched -- see above", file=sys.stderr)
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
