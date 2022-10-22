extends Camera2D


var map

func _ready():
	map = get_parent().get_node("level")
	zoom *= map.level_scaling

func _process(delta):
	position.x = map.current_level_center.x
	position.y = map.current_level_center.y
