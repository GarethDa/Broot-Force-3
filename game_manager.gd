extends Node2D
@export var floorCollider: CollisionShape2D
@export var playerSeed: Node2D
@export var colliderHolder : Node2D

var floorTileCount = 1

var floorWidth : float
# Called when the node enters the scene tree for the first time.
func _ready():
	floorWidth = floorCollider.shape.get_rect().size.x
	print(floorWidth)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (playerSeed.position.x >= floorTileCount * floorWidth - 50):
		var newCollider = floorCollider.duplicate()
		newCollider.position.x = (floorTileCount * floorWidth) + (0.5 * floorWidth)
		colliderHolder.add_child(newCollider)
		floorTileCount += 1
	pass
