# Amaze

A simple grid maze game — learning [Godot](https://godotengine.org/) one system at a time.

**Engine:** Godot 4.7 · **Project name in editor:** Amaze

## What’s here

Prototype maze navigation on a 32px tile grid:

- **Player** (`player.gd` / `player.tscn`) — `CharacterBody2D` that steps one tile at a time (tap = one cell, hold = keep stepping). Cardinal only via Input Map actions `move_*` (arrows + WASD). Blocks on wall cells with a point query at the destination tile center.
- **Wall** (`wall.gd` / `wall.tscn`) — sized `StaticBody2D` with matching collision and `Polygon2D` visual. Placed on tile centers.
- **Maze** (`maze.tscn`) — bordered room, middle barrier, player spawn. Main scene.

Physics layers: `walls` (1), `player` (2).

## Design notes

- Movement is **grid occupancy**, not continuous physics sliding.
- Wall and actor positions use **tile centers**: `(col + 0.5, row + 0.5) * tile_size`.
- Next up when you’re ready: better maze authoring (e.g. TileMap), collectibles, win condition — not ghost AI.

## Requirements

- [Godot 4.7+](https://godotengine.org/download/) (Forward Plus)

## Run

1. Open this folder in Godot.
2. Main scene is `maze.tscn` (F5), or open it and press F6.
3. Click **Input** on the game window if keys do nothing.
4. Move with **arrow keys** or **WASD**.

## Tooling

- **gdstyle** editor plugin (`addons/gdstyle`) — GDScript linter/formatter (enabled in `project.godot`)
- Style config: `gdstyle.toml` (tabs, type hints preferred, `addons` excluded from lint)
