extends Node2D

export var level_dimensions := Vector2(16,9)
export var level_scaling := 1
export var level_cell_size := 64

var current_level
var current_level_center

func _ready():
	level_dimensions = level_dimensions * level_scaling * level_cell_size
	position = level_dimensions/2
	current_level = Vector2(0,0)
	current_level_center = Vector2(0,0)

func _physics_process(delta):
	update_current_level()

func update_current_level():
	if $player.position.x >= level_dimensions.x/2:
		current_level.x = int($player.position.x/(level_dimensions.x))+1
	elif $player.position.x < level_dimensions.x/2 and $player.position.x > -level_dimensions.x/2:
		current_level.x = int($player.position.x/(level_dimensions.x))
	else:
		current_level.x = int($player.position.x/(level_dimensions.x))-1
		
	if $player.position.y >= level_dimensions.y/2:
		current_level.y = int($player.position.y/(level_dimensions.y))+1
	elif $player.position.y < level_dimensions.y/2 and $player.position.y > -level_dimensions.y/2:
		current_level.y = int($player.position.y/(level_dimensions.y))
	else:
		current_level.y = int($player.position.y/(level_dimensions.y))-1
	
	current_level_center = level_dimensions * current_level + level_dimensions/2
