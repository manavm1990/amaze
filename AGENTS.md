# AGENTS.md

## Project Context

**Amaze** is a learning project: a simple grid maze game in Godot 4.7+ (Forward Plus).

- **Engine**: Godot 4.7, Forward Plus (per `config/features` in `project.godot`)
- **Language**: GDScript with type hints
- **Style**: See `gdstyle.toml` — tabs, 100-col max, type hints preferred
- **Goal**: Learn Godot fundamentals through small, complete systems — not a full arcade clone

## Game model

- **Grid**: 32px tiles; nodes sit on **tile centers**
- **Movement**: one cell per step; tap vs hold; cardinal only (`move_up` / `move_down` / `move_left` / `move_right` in the Input Map)
- **Blocking**: destination cell is a wall if a physics point query at that cell center hits the `walls` layer
- Prefer **grid/tile data** for future maze growth (TileMap); avoid full-body shape queries for step permission

## Physics & Nodes

- **Layers**: `walls` (1), `player` (2)
- **Core nodes**:
  - `Player` → `CharacterBody2D` (floating motion mode); position animated between cell centers
  - `Wall` → `StaticBody2D` with matching collision/visual
  - `Maze` (main scene) → `Node2D`

## How to Work With Me

### Scene edits
Don't edit `.tscn` / `.uid` / `.import` files as text — UIDs and sub-resource IDs corrupt silently. Describe the change (e.g., "add a Sprite2D child to Player"), and I'll do it in the editor or via GDScript.

### Code changes
When adding or refactoring a system:
1. Explain the Godot API choice and *why* it's suitable here (reference [docs.godotengine.org/en/stable](https://docs.godotengine.org/en/stable) when it matters)
2. Write the code
3. Keep explanations brief—the learning is in reading the code, not my commentary

### Testing
After changes, verify:
- `gdstyle check` passes (`gdstyle check --fix` for safe auto-fixes, `gdstyle fmt` to format in place)
- The scene runs without errors (F5 main scene / F6 current scene)

## References

- [Godot GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/style_guide.html)
- [Godot Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)
- [Using TileMaps](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html)
- [CharacterBody2D / Physics](https://docs.godotengine.org/en/stable/tutorials/physics/using_2d_characters/index.html)
