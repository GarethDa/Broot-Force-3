extends Line2D

@export var player : Node2D
@export var origin : Node2D
@export var arcLengthToAddPoint : float

var arcLength : float = 0
var lastPos : Vector2

func _ready() -> void:
	set_point_position(0,origin.global_position)

func _process(delta: float) -> void:
	var distanceTravelled = player.global_position.distance_to(lastPos)
	if not lastPos:
		lastPos = player.global_position
	arcLength += distanceTravelled
	if arcLength >= arcLengthToAddPoint:
		add_point(player.global_position)
		arcLength = 0
		lastPos = player.global_position
	
	set_point_position(get_point_count()-1,player.global_position)
	
