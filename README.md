# man-pac

Learning [Godot](https://godotengine.org/) by recreating Pac-Man.

**Engine:** Godot 4.7 · **Project name in editor:** Man-Pac

## What’s here

Early prototype of maze navigation:

- **Player** (`player.gd` / `player.tscn`) — `CharacterBody2D` with cardinal-only movement (arrow keys or WASD). Direction changes only when the path is clear (`test_move`), so you can’t cut through walls or go diagonal.
- **Wall** (`wall.gd` / `wall.tscn`) — sized `StaticBody2D` with matching collision and `Polygon2D` visual.
- **Maze** (`maze.tscn`) — simple bordered room with a middle barrier and a player spawn.

Physics layers: `walls` (1), `player` (2).

## Requirements

- [Godot 4.7+](https://godotengine.org/download/) (Forward Plus)

## Run

1. Open the project folder in Godot.
2. Set **Maze** (`maze.tscn`) as the main scene if it isn’t already (Project → Project Settings → Application → Run → Main Scene), or open `maze.tscn` and press **F6** to run the current scene.
3. Move with **arrow keys** or **WASD**.

## Tooling

- **gdstyle** editor plugin (`addons/gdstyle`) — GDScript linter/formatter integration (enabled in `project.godot`)
- Style config: `gdstyle.toml` (tabs, type hints preferred, `addons` excluded from lint)
