# 《金庸群侠传：龙启江湖》macOS native port

《金庸群侠传：龙启江湖》was originally developed by grgame. I reverse engineered `Dragon.exe`, and ported it to macOS.

Docs:
- **[docs/REVERSE.md](docs/REVERSE.md)** - the detailed reverse engineering process, starting from unpacking `Dragon.exe`, getting the Lua and the assets out of it, the engine behaviour recovered from the original binary, and how to drive IDA through `ida-pro-mcp`.
- **[docs/DEV.md](docs/DEV.md)** - game-directory layout, the `.app` bundle, formatting, source map, status, assets.

## Dependencies
```
brew install sdl3 luajit freetype libpng
```

## Build & run
```
make
make run
```
