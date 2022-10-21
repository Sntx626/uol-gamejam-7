extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	position.x = get_parent().get_node("level").current_level_center.x
	position.y = get_parent().get_node("level").current_level_center.y
