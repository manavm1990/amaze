class_name Wall
extends StaticBody2D

@export var size := Grid.TILE_SIZE:
	set(value):
		size = value
		_update_shape()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var polygon: Polygon2D = $Polygon2D


func _ready() -> void:
	_update_shape()


func _update_shape() -> void:
	if not is_instance_valid(collision_shape) or not is_instance_valid(polygon):
		return

	var half := size / 2.0
	var rectangle_shape := RectangleShape2D.new()
	rectangle_shape.size = size
	collision_shape.shape = rectangle_shape
	polygon.polygon = PackedVector2Array([
		Vector2(-half.x, -half.y),
		Vector2(half.x, -half.y),
		Vector2(half.x, half.y),
		Vector2(-half.x, half.y),
	])
