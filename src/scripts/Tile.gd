extends Node


var position
var tileset

func _ready():
	tileset = ""
	position = Vector2(0, 0)

func set_position(pos:Vector2):
	position = pos

func get_position() -> Vector2:
	return position

func set_tileset(name):
	tileset = name

func get_tileset():
	return tileset
