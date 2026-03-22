extends Sprite2D

var screenSize : Vector2

func _ready() -> void:
	screenSize = get_viewport().get_visible_rect().size
	
func _process(delta: float) -> void:
	material.set_shader_parameter("position",get_parent().global_position)
