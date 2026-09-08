#!/bin/sh
# Assemble a macOS .app around build/jyengine.
#
#   tools/make_app.sh <bundle.app> <binary> <icon.icns> <game-dir>
#
# The bundle is self-contained: the game data goes into Contents/Resources, and
# the Homebrew dylibs are copied in and rewritten to @rpath, because an .app
# that depends on /opt/homebrew stops working the moment those are upgraded.
#
# NOT signed as a bundle, deliberately. The game writes its saves in place --
# Byte.savefile opens r+b and patches at a byte offset -- and those files live
# in Contents/Resources/game/save/. Sealing the bundle would make every save
# invalidate its own signature. The executable and dylibs are ad-hoc signed
# individually, which is all arm64 requires to run them.
set -eu

if [ $# -ne 4 ]; then
    echo "usage: $0 <bundle.app> <binary> <icon.icns> <game-dir>" >&2
    exit 2
fi
APP="$1"; BIN="$2"; ICON="$3"; GAME="$4"

for f in "$BIN" "$ICON"; do
    if [ ! -f "$f" ]; then echo "$0: no such file: $f" >&2; exit 2; fi
done
NAME="$(basename "$APP" .app)"
MACOS="$APP/Contents/MacOS"
FRAMEWORKS="$APP/Contents/Frameworks"
RES="$APP/Contents/Resources"

# Clear the code directories but never Resources -- a self-contained bundle
# keeps its save/ in there. Otherwise renaming the app leaves the previous
# executable behind and the bundle carries two of them.
rm -rf "$MACOS" "$FRAMEWORKS"
mkdir -p "$MACOS" "$FRAMEWORKS" "$RES"
# Name the executable after the bundle: CFBundleExecutable drives the window's
# owning app, but the Dock, Force Quit and Activity Monitor all show the
# process name, which comes from the file itself.
cp "$BIN" "$MACOS/$NAME"
cp "$ICON" "$RES/AppIcon.icns"

# ---- dylibs -----------------------------------------------------------------
# Walk the dependency graph rather than hardcoding a list: freetype pulls in
# libpng, and a future dependency should not need this script edited.
needs_bundling() {
    case "$1" in
        /opt/homebrew/*|/usr/local/*) return 0 ;;
        *) return 1 ;;
    esac
}

deps_of() { otool -L "$1" | tail -n +2 | awk '{print $1}'; }

# The worklist holds bare library names, never paths: the bundle directory can
# contain spaces, and a POSIX shell has no arrays, so anything path-shaped in
# an unquoted `for` would split.
copied=""
pending=""

rewrite_deps() {                       # $1 = object to fix up
    for dep in $(deps_of "$1"); do
        needs_bundling "$dep" || continue
        base="$(basename "$dep")"
        case " $copied " in
            *" $base "*) ;;
            *)
                cp -f "$dep" "$FRAMEWORKS/$base"
                chmod u+w "$FRAMEWORKS/$base"
                install_name_tool -id "@rpath/$base" "$FRAMEWORKS/$base" 2>/dev/null || true
                copied="$copied $base"
                pending="$pending $base"
                ;;
        esac
        install_name_tool -change "$dep" "@rpath/$base" "$1" 2>/dev/null || true
    done
}

rewrite_deps "$MACOS/$NAME"
while [ -n "$pending" ]; do
    todo="$pending"
    pending=""
    for base in $todo; do rewrite_deps "$FRAMEWORKS/$base"; done
done
install_name_tool -add_rpath "@executable_path/../Frameworks" "$MACOS/$NAME" 2>/dev/null || true

# Drop rpaths pointing outside the bundle. pkg-config hands the link line a
# -rpath /opt/homebrew/lib, and rpaths are searched in order -- leaving it in
# means dyld keeps preferring Homebrew's copies and the bundling is a no-op
# on the machine that built it, which is exactly where it would go unnoticed.
otool -l "$MACOS/$NAME" | awk '/LC_RPATH/{f=1} f&&/ path /{print $2; f=0}' |
while read -r rp; do
    case "$rp" in
        @executable_path/*|@loader_path/*) ;;
        *) install_name_tool -delete_rpath "$rp" "$MACOS/$NAME" 2>/dev/null || true ;;
    esac
done

# ---- game data --------------------------------------------------------------
# save/ is copied only when absent: the game writes those files in place, so a
# rebuild must not clobber progress. Everything else is mirrored.
rsync -a --delete \
    --exclude 'save/' --exclude 'port_debug.txt' \
    --exclude '.DS_Store' --exclude 'Thumbs.db' \
    "$GAME/" "$RES/game/"
if [ ! -d "$RES/game/save" ]; then
    cp -R "$GAME/save" "$RES/game/save"
    echo "  seeded save/ (delete it in the bundle to reset)"
else
    echo "  kept existing save/ in the bundle"
fi

# ---- Info.plist -------------------------------------------------------------
cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleName</key>              <string>$NAME</string>
	<key>CFBundleDisplayName</key>       <string>$NAME</string>
	<key>CFBundleExecutable</key>        <string>$NAME</string>
	<key>CFBundleIdentifier</key>        <string>local.jyengine.dragon</string>
	<key>CFBundleIconFile</key>          <string>AppIcon</string>
	<key>CFBundlePackageType</key>       <string>APPL</string>
	<key>CFBundleInfoDictionaryVersion</key> <string>6.0</string>
	<key>CFBundleShortVersionString</key><string>0.1</string>
	<key>CFBundleVersion</key>           <string>1</string>
	<key>LSMinimumSystemVersion</key>    <string>11.0</string>
	<key>LSApplicationCategoryType</key> <string>public.app-category.role-playing-games</string>
	<key>NSHighResolutionCapable</key>   <true/>
	<key>NSHumanReadableCopyright</key>
	<string>Game content by grgame. Engine: reverse-engineered native port. Not for redistribution.</string>
</dict>
</plist>
PLIST

# ---- ad-hoc signatures ------------------------------------------------------
# install_name_tool invalidates whatever the linker put there, and arm64
# refuses to execute unsigned code.
for f in "$FRAMEWORKS"/*.dylib; do
    if [ -e "$f" ]; then codesign -f -s - "$f" >/dev/null 2>&1 || true; fi
done

# Sign the executable *outside* the bundle. Handed a path that is the bundle's
# CFBundleExecutable, codesign signs the enclosing bundle instead of the file,
# writing Contents/_CodeSignature and sealing Resources -- which every save
# written into Resources/game/save/ would then invalidate. Staging it in /tmp
# gets a plain Mach-O signature, the same state a freshly linked binary is in.
# Explicit template: BSD mktemp accepts `-t prefix`, GNU coreutils' does not,
# and Homebrew's may be first on PATH.
STAGE="$(mktemp "${TMPDIR:-/tmp}/jyexe.XXXXXX")"
mv "$MACOS/$NAME" "$STAGE"
codesign -f -s - -i local.jyengine.dragon "$STAGE" >/dev/null 2>&1 || true
mv "$STAGE" "$MACOS/$NAME"
chmod +x "$MACOS/$NAME"
rm -rf "$APP/Contents/_CodeSignature"

echo "built $APP ($(du -sh "$APP" | cut -f1))"
