class_name Grid
extends RefCounted

const TILE_SIZE := Vector2(TILE_UNIT, TILE_UNIT)
const TILE_UNIT := 32.0


# Example: cell (0, 0) → world position (16, 16) (center of first tile)
# `world` is...the world in pixels
static func cell_to_world(cell: Vector2i) -> Vector2:
	return (Vector2(cell) + Vector2(0.5, 0.5)) * TILE_UNIT


## Nearest tile-center world position for `world`.
static func snap_to_tile_center(world: Vector2) -> Vector2:
	return cell_to_world(world_to_cell(world))


## World position → cell index containing that point.
static func world_to_cell(world: Vector2) -> Vector2i:
	return Vector2i(floori(world.x / TILE_UNIT), floori(world.y / TILE_UNIT))
