extends Node2D

@export var seedCharacter: CharacterBody2D
@export var minAngle = -85
@export var maxAngle = 85
@export var rotateSpeed = 100

signal seedLaunched(direction: Vector2)

var rotatingUp = true
var doneLaunching = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!doneLaunching):
		if (rotatingUp):
			rotation_degrees += rotateSpeed * delta
			if (rotation_degrees > maxAngle):
				rotation_degrees = maxAngle
				rotatingUp = false
		else:
			rotation_degrees -= rotateSpeed * delta
			if (rotation_degrees < minAngle):
				rotation_degrees = minAngle
				rotatingUp = true

	if (Input.is_action_just_pressed("select_angle") && !doneLaunching):
		seedLaunched.emit(global_transform.x)
		doneLaunching = true
