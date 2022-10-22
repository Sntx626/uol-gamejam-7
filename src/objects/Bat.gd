extends KinematicBody2D

export var speed = 300
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var path = []
var threshold = 16
var nav = null

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(owner, "ready")
	nav = owner.nav

func _physics_process(delta):
	if (path.size() > 0):
		move_to_target()
		
func move_to_target():
	if position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = position.direction_to(path[0])
		velocity = direction * speed
		velocity = move_and_slide(velocity)
		
func get_target_path(target_pos):
	print(position, target_pos, nav.get_simple_path(position, target_pos, false))
	path = nav.get_simple_path(position, target_pos, true)
	owner.get_node("Line2D").points = path

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
