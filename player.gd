class_name Player
extends CharacterBody2D

@export var speed := 200.0

var _is_moving := false
var _target_position := Vector2.ZERO


func _ready() -> void:
	global_position = Grid.snap_to_tile_center(global_position)
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


# Grid rule: the next tile is allowed iff its center is not inside a wall.
func _can_step(step_direction: Vector2i) -> bool:
	var target_cell := Grid.world_to_cell(global_position) + step_direction
	return not _is_wall_at_cell(target_cell)


# Cardinal-only: one axis at a time (priority up, down, left, right).
func _get_requested_direction() -> Vector2i:
	if Input.is_action_pressed("move_up"):
		return Vector2i.UP
	if Input.is_action_pressed("move_down"):
		return Vector2i.DOWN
	if Input.is_action_pressed("move_left"):
		return Vector2i.LEFT
	if Input.is_action_pressed("move_right"):
		return Vector2i.RIGHT
	return Vector2i.ZERO


# Does this cell's center collide with a wall?
func _is_wall_at_cell(cell: Vector2i) -> bool:
	var query := PhysicsPointQueryParameters2D.new() # What bodies at this point?
	query.position = Grid.cell_to_world(cell)
	query.collision_mask = collision_mask
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [get_rid()]

	return not get_world_2d().direct_space_state.intersect_point(query, 1).is_empty()


func _try_start_step() -> void:
	var step_direction := _get_requested_direction()
	if step_direction == Vector2i.ZERO:
		return
	if not _can_step(step_direction):
		return
	var target_cell := Grid.world_to_cell(global_position) + step_direction
	_target_position = Grid.cell_to_world(target_cell)
	_is_moving = true
