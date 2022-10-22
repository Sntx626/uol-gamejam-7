extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.


onready var parentAni = get_parent().get_node("PlayerSprite")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if (not flip_h == parentAni.flip_h):
		flip_h = parentAni.flip_h
		offset.x = offset.x * -1
	print()
	rotate(get_angle_to(get_global_mouse_position())+deg2rad(205 if flip_h else -25))
