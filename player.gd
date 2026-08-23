class_name Player
extends CharacterBody2D

@export var speed: float = 200.0
@export var tile_size: float = 32.0

var _target_position: Vector2 = Vector2.ZERO
var _is_moving: bool = false


func _ready() -> void:
	global_position = _snap_to_tile_center(global_position)
	_target_position = global_position


func _physics_process(delta: float) -> void:
	if _is_moving:
		global_position = global_position.move_toward(_target_position, speed * delta)
		if global_position.distance_to(_target_position) <= 0.01:
			global_position = _target_position
			_is_moving = false
			_try_start_step()
		return

	_try_start_step()


# Cardinal-only: one axis at a time (priority up, down, left, right).
func _get_requested_direction() -> Vector2:
	if Input.is_action_pressed("move_up"):
		return Vector2.UP
	if Input.is_action_pressed("move_down"):
		return Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		return Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		return Vector2.RIGHT
	return Vector2.ZERO


func _try_start_step() -> void:
	var step_direction: Vector2 = _get_requested_direction()
	if step_direction == Vector2.ZERO:
		return
	if not _can_step(step_direction):
		return
	_target_position = global_position + step_direction * tile_size
	_is_moving = true


# Grid rule: the next tile is allowed iff its center is not inside a wall.
# A full-body shape query is the wrong tool here — open cells share edges with
# wall cells, so a 32×32 body always "collides" with neighbors and never moves.
func _can_step(step_direction: Vector2) -> bool:
	var target_position: Vector2 = global_position + step_direction * tile_size
	return not _is_wall_cell(target_position)


func _is_wall_cell(cell_center: Vector2) -> bool:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = cell_center
	query.collision_mask = collision_mask
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [get_rid()]

	var hits: Array[Dictionary] = get_world_2d().direct_space_state.intersect_point(query, 1)
	return not hits.is_empty()


# Wall and actor positions use tile centers: (col + 0.5, row + 0.5) * tile_size.
func _snap_to_tile_center(pos: Vector2) -> Vector2:
	var half: float = tile_size * 0.5
	return Vector2(
		floorf(pos.x / tile_size) * tile_size + half,
		floorf(pos.y / tile_size) * tile_size + half,
	)
