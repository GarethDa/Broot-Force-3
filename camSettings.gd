extends Camera2D

@export var player: Node2D
@export var cameraOffset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position + cameraOffset


func _on_seed_holder_player_swapped(focusedPlayed):
	player = focusedPlayed
