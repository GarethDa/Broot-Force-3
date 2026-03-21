extends RigidBody2D

@export var rotationSpeed: float = 1
@export var launchSpeed: float = 1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var launched = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	freeze = true
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
	pass
	#if (launched):
		#velocity.x = launchSpeed
		#velocity.y += gravity * delta
		#move_and_slide()

func _on_launcher_seed_launched(direction):
	launched = true
	freeze = false
	apply_impulse(direction * launchSpeed)
	#velocity = direction * launchSpeed
