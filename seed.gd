extends CharacterBody2D

@export var rotationSpeed: float = 1
@export var launchSpeed: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotationDelta = 0
	if Input.is_action_pressed("tilt_clockwise"):
		rotationDelta += 0.1
	if Input.is_action_pressed("tilt_counterclockwise"):
		rotationDelta -= 0.1
	
	rotation += rotationDelta * rotationSpeed
	
func _physics_process(delta):
	velocity = Vector2(launchSpeed, 0)
	move_and_slide()
