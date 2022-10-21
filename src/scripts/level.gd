extends Node2D

export var level_width := 16
export var level_height := 9
export var level_scaling := 1
export var level_cell_size := 64
var l_width
var l_height

var current_level
var current_level_center

func _ready():
	l_width = level_width * level_scaling * level_cell_size
	l_height = level_height * level_scaling * level_cell_size
	current_level = Vector2(0,0)
	current_level_center = Vector2(0,0)

func _physics_process(delta):
	update_current_level()

func update_current_level():
	if $player.position.x >= 0:
		current_level.x = int($player.position.x/(l_width))
	else:
		current_level.x = int($player.position.x/(l_width))-1
	if $player.position.y >= 0:
		current_level.y = int($player.position.y/(l_height))
	else:
		current_level.y = int($player.position.y/(l_height))-1
	
	current_level_center.x = 1024 * current_level.x + 512
	current_level_center.y = 576 * current_level.y + 288
