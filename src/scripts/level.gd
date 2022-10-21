extends Node2D

var current_level_center = Vector2(0,0)

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	update_current_level()

func update_current_level():
	current_level_center.x = 1024 * int($player.position.x/(16*64)) + 512
	current_level_center.y = 576 * int($player.position.y/(16*64)) + 288

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
