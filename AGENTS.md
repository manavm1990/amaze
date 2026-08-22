# AGENTS.md

## Project Context

**Man-Pac** is a learning project recreating Pac-Man in Godot 4.7+ (Forward Plus).

- **Engine**: Godot 4.7, Forward Plus (per `config/features` in `project.godot`)
- **Language**: GDScript with type hints
- **Style**: See `gdstyle.toml` — tabs, 100-col max, type hints preferred
- **Goal**: Learn Godot fundamentals through incremental gameplay systems, not copy-paste working code

## Physics & Nodes

- **Layers**: `walls` (1), `player` (2)
- **Core nodes**:
  - `Player` → `CharacterBody2D` with cardinal-only input via `test_move()`
  - `Wall` → `StaticBody2D` with matching collision/visual
  - `Maze` (root scene) → `Node2D` with physics setup

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
- The scene runs without errors (F6 in editor or `Main Scene → Run`)

## References

- [Godot GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/style_guide.html)
- [Godot Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)
- [CharacterBody2D / Physics](https://docs.godotengine.org/en/stable/tutorials/physics/using_2d_characters/index.html)
