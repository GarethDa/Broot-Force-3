extends Node2D
@export var gliderSeedCollider: CollisionShape2D
@export var propellerSeedCollider: CollisionShape2D
@export var gliderToPropellerVelocityScale: float = 0.5

var gliderSeed: Node2D
var propellerSeed: Node2D
signal playerSwapped(focusedPlayed: Node2D)


# Called when the node enters the scene tree for the first time.
func _ready():
	propellerSeedCollider.get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	gliderSeed = gliderSeedCollider.get_parent()
	propellerSeed = propellerSeedCollider.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("use_propeller")):
		
		#propellerSeed.process_mode = Node.PROCESS_MODE_ALWAYS
		#propellerSeed.position = gliderSeed.position
		#gliderSeed.process_mode = Node.PROCESS_MODE_DISABLED
		#gliderSeed.hide()
		
		propellerSeed.process_mode = Node.PROCESS_MODE_ALWAYS
		propellerSeed.show()
		propellerSeedCollider.disabled = false
		propellerSeed.position = gliderSeed.position
		propellerSeed.set_full_rotation(gliderSeed.get_node("RotationNode").rotation_degrees)
		
		gliderSeed.set_new_forward_speed(0)
		gliderSeed.process_mode = Node.PROCESS_MODE_DISABLED
		gliderSeed.hide()
		gliderSeedCollider.disabled = true
		
		playerSwapped.emit(propellerSeed)
	
	if (Input.is_action_just_released("use_propeller")):
		#gliderSeed.process_mode = Node.PROCESS_MODE_ALWAYS
		#gliderSeed.position = propellerSeed.position
		#propellerSeed.process_mode = Node.PROCESS_MODE_DISABLED
		
		gliderSeed.process_mode = Node.PROCESS_MODE_ALWAYS
		gliderSeed.show()
		gliderSeedCollider.disabled = false
		gliderSeed.position = propellerSeed.position
		gliderSeed.set_full_rotation(propellerSeed.get_node("RotationNode").rotation_degrees)
		
		propellerSeed.linear_velocity = Vector2.ZERO
		propellerSeed.process_mode = Node.PROCESS_MODE_DISABLED
		propellerSeed.hide()
		propellerSeedCollider.disabled = true
		
		playerSwapped.emit(gliderSeed)
