class_name Player
extends CharacterBody2D

@export var speed: float = 200.0

var direction: Vector2 = Vector2.ZERO

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	var requested_direction: Vector2 = _get_requested_direction()
	if requested_direction != Vector2.ZERO and _can_move(requested_direction, delta):
		direction = requested_direction
	elif not _can_move(direction, delta):
		direction = Vector2.ZERO

	velocity = direction * speed
	move_and_slide()


# Cardinal-only input: never combine axes, so movement can't go diagonal.
# Checked in priority order (up, down, left, right) when multiple keys are held.
func _get_requested_direction() -> Vector2:
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		return Vector2.UP
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		return Vector2.DOWN
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		return Vector2.LEFT
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		return Vector2.RIGHT
	return Vector2.ZERO


# Uses a non-moving collision test so this stays correct once maze walls
# (StaticBody2D + CollisionShape2D) are added, with no changes needed here.
func _can_move(check_direction: Vector2, delta: float) -> bool:
	if check_direction == Vector2.ZERO:
		return false
	var motion: Vector2 = check_direction * speed * delta
	return not test_move(global_transform, motion)
