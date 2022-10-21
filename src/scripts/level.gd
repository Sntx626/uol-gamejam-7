extends Node2D

export var level_dimensions := Vector2(16,10)
export var level_scaling := 2
export var level_cell_size := 64

var dimensions
var current_level
var current_level_center

func _ready():
	dimensions = level_dimensions * level_scaling * level_cell_size
	position = dimensions/2
	current_level = Vector2(0,0)
	current_level_center = Vector2(0,0)

func _physics_process(delta):
	update_current_level()

func update_current_level():
	if $player.position.x >= dimensions.x/2:
		current_level.x = int($player.position.x/(dimensions.x))+1
	elif $player.position.x < dimensions.x/2 and $player.position.x > -dimensions.x/2:
		current_level.x = int($player.position.x/(dimensions.x))
	else:
		current_level.x = int($player.position.x/(dimensions.x))-1
		
	if $player.position.y >= dimensions.y/2:
		current_level.y = int($player.position.y/(dimensions.y))+1
	elif $player.position.y < dimensions.y/2 and $player.position.y > -dimensions.y/2:
		current_level.y = int($player.position.y/(dimensions.y))
	else:
		current_level.y = int($player.position.y/(dimensions.y))-1
	
	current_level_center = dimensions * current_level + dimensions/2
	#current_level_center.y += 32
