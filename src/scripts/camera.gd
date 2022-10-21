extends Camera2D


var map

func _ready():
	map = get_parent().get_node("level")
	zoom *= map.level_scaling
	zoom *= 0.8

func _process(delta):
	position.x = map.current_level_center.x
	position.y = map.current_level_center.y
