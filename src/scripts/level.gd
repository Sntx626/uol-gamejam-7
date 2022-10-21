extends Node2D

export var level_dimensions := Vector2(16,10)
export var level_scaling := 2
export var level_cell_size := 64

onready var player = $player
onready var nav = $Navigation2D

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
	if $player.position.x >= 0:
		current_level.x = int(($player.position.x+dimensions.x/2)/dimensions.x)
	else:
		current_level.x = int(($player.position.x-dimensions.x/2)/dimensions.x)
		
	if $player.position.y >= 0:
		current_level.y = int(($player.position.y+dimensions.y/2)/dimensions.y)
	else:
		current_level.y = int(($player.position.y-dimensions.y/2)/dimensions.y)
	
	current_level_center = dimensions * current_level + dimensions/2


func _on_Timer_timeout():
	get_tree().call_group("Bat", "get_target_path", player.position)

