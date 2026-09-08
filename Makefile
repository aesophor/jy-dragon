# Native macOS engine for Dragon.exe (金庸群侠传 mod)
# Reimplements the 46-function `lib` table + 11-function `Byte` table that the
# game's Lua expects, on SDL3 + LuaJIT + FreeType + libpng.
#
# All build products land in build/ ; nothing is written next to the sources.

CC       := clang
BUILD    := build
PKGS     := sdl3 luajit freetype2 libpng

CFLAGS   := -std=c11 -O2 -g -Wall -Wextra -Wno-unused-parameter \
            $(shell pkg-config --cflags $(PKGS)) -Isrc
LDFLAGS  := $(shell pkg-config --libs $(PKGS)) -liconv \
            -framework AudioToolbox -framework CoreFoundation

SRC      := $(wildcard src/*.c)
OBJ      := $(SRC:src/%.c=$(BUILD)/%.o)
DEP      := $(OBJ:.o=.d)
BIN      := $(BUILD)/jyengine

all: $(BIN)

$(BIN): $(OBJ)
	@mkdir -p $(@D)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

# -MMD -MP records header dependencies, so editing engine.h rebuilds what
# actually includes it instead of silently leaving stale objects behind.
$(BUILD)/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -MMD -MP -c -o $@ $<

-include $(DEP)

# Style is pinned by .clang-format; the generated s2t table is fenced off
# inside the file itself.
format:
	clang-format -i src/*.c src/*.h

format-check:
	@clang-format --dry-run --Werror src/*.c src/*.h && echo "src/ is formatted"

clean:
	rm -rf $(BUILD)

# Run against the bundled game data
run: $(BIN)
	./$(BIN) game

# ---- .app bundle ------------------------------------------------------------
# Self-contained, ~300 MB: the game data lives in Contents/Resources, so the
# bundle is double-clickable with nothing beside it. The Homebrew dylibs are
# copied in and rewritten to @rpath. It is not signed as a bundle -- the game
# writes its saves in place, which would break a sealed signature; see
# tools/make_app.sh.
APP_NAME ?= 金庸群俠傳之龍啟江湖
APP      := $(BUILD)/$(APP_NAME).app
ICON     := game/AppIcon.icns

# Supplied alongside the game data, not generated. It is committed with the
# rest of game/; declaring it as a target still gives a useful message instead
# of make's "No rule to make target" for a tree assembled by hand.
$(ICON):
	@echo "missing $@ -- put an .icns there (iconutil -c icns AppIcon.iconset)" >&2
	@exit 1

app: $(BIN) $(ICON)
	tools/make_app.sh "$(APP)" $(BIN) $(ICON) game

# Install into ~/Applications, where no admin rights are needed
install-app: app
	rm -rf "$(HOME)/Applications/$(APP_NAME).app"
	mkdir -p "$(HOME)/Applications"
	cp -R "$(APP)" "$(HOME)/Applications/"
	@echo "installed to ~/Applications/$(APP_NAME).app"

.PHONY: all clean run app install-app format format-check
