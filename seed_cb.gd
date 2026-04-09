extends CharacterBody2D

@export var rotationSpeed: float = 1
@export var launchSpeed: float = 1
@export var propellerStrength: float = 1
@export var rotationTracker: Node2D
@export var gravityScale: float = 1
@export var airDrag: float = 1
@export var groundFriction: float = 1
@export var dragPerDegree: float = 1
#@export var 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var launched = false;

var forwardVelocityLength: float
var forwardVelocityDirection: Vector2
var totalVelocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	#gravity_scale = gravityScale
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if (launched):
		totalVelocity = Vector2.ZERO
		var rotationDelta = 0
		if Input.is_action_pressed("tilt_clockwise"):
			rotationDelta += 0.1
		if Input.is_action_pressed("tilt_counterclockwise"):
			rotationDelta -= 0.1
			
		#Rotate children, don't rotate the rigidbody itself (that would break shit)
		for child in get_children():
			child.global_rotation += rotationDelta * rotationSpeed * delta
		
		if (Input.is_action_pressed("use_propeller")):
			airDrag += 10
			totalVelocity += -rotationTracker.global_transform.y * propellerStrength * 1000 * delta
		
		if (Input.is_action_just_released("use_propeller")):
			airDrag -= 10
		
		if (is_on_floor()):
			forwardVelocityLength = move_toward(forwardVelocityLength, 0, groundFriction * 1000)
		
		var currentDrag = airDrag - (rotationTracker.rotation_degrees * dragPerDegree)
		
		if (forwardVelocityLength <= 0 && !is_on_floor()):
			forwardVelocityLength = 0.1
		
		forwardVelocityLength = move_toward(forwardVelocityLength, 0, currentDrag)
		totalVelocity += forwardVelocityLength * rotationTracker.global_transform.x * delta
		totalVelocity += get_gravity() * gravityScale
		
		velocity = totalVelocity
		print("Speed: " + str(velocity.length()))
		move_and_slide()

func _on_launcher_seed_launched(rotationDegrees):
	launched = true
	set_full_rotation(rotationDegrees)
	
	forwardVelocityLength = launchSpeed * 1000
	#apply_impulse(roatationTracker.global_transform.x * launchSpeed)
	#velocity = direction * launchSpeed

func set_full_rotation(rotationDegrees: float):
	var rotationDelta = rotationDegrees - rotationTracker.rotation_degrees
	for child in get_children():
			child.global_rotation_degrees += rotationDelta
			
func set_new_forward_speed(newSpeed):
	forwardVelocityLength = newSpeed
