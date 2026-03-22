extends Node2D

@export var speed : float

var screenSize : Vector2

func _ready() -> void:
	screenSize = get_viewport().get_visible_rect().size
	
func _process(delta: float) -> void:
	var cursorPosition = get_viewport().get_mouse_position()
	var directionToMove = cursorPosition - (screenSize/2)
	directionToMove = directionToMove.normalized()
	get_parent().global_position += directionToMove * delta * speed
