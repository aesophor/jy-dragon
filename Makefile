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

.PHONY: all clean run format format-check
