extends RigidBody2D

@export var rotationSpeed: float = 1
@export var launchSpeed: float = 1
@export var propellerStrength: float = 1
@export var rotationTracker: Node2D
@export var gravityScale: float = 1
#@export var 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var launched = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	freeze = true
	gravity_scale = gravityScale
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if (launched):
		var rotationDelta = 0
		if Input.is_action_pressed("tilt_clockwise"):
			rotationDelta += 0.1
		if Input.is_action_pressed("tilt_counterclockwise"):
			rotationDelta -= 0.1
			
		#Rotate children, don't rotate the rigidbody itself (that would break shit)
		for child in get_children():
			child.global_rotation += rotationDelta * rotationSpeed
		
		if (Input.is_action_pressed("use_propeller")):
			apply_force(-rotationTracker.global_transform.y * 100 * propellerStrength)

func _on_launcher_seed_launched(rotationDegrees):
	launched = true
	freeze = false
	var rotationDelta = rotationDegrees - rotationTracker.rotation_degrees
	for child in get_children():
			child.global_rotation_degrees += rotationDelta
	apply_impulse(rotationTracker.global_transform.x * launchSpeed)

func set_full_rotation(rotationDegrees):
	var rotationDelta = rotationDegrees - rotationTracker.rotation_degrees
	for child in get_children():
			child.global_rotation_degrees += rotationDelta

func _calculate_lift():
	
	pass
