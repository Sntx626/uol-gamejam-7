extends Node


var position:Vector2
var tile:int
var flip_x:bool
var flip_y:bool
var transpose:bool
var autotile_coord:Vector2

func set_position(pos:Vector2):
	position = pos
func get_position() -> Vector2:
	return position

func set_tile(id:int) -> void:
	tile = id
func get_tile() -> int:
	return tile

func set_flip_x(flip:bool) -> void:
	flip_x = flip
func get_flip_x() -> bool:
	return flip_x

func set_flip_y(flip:bool) -> void:
	flip_y = flip
func get_flip_y() -> bool:
	return flip_y

func set_transpose(transp:bool) -> void:
	transpose = transp
func get_transpose() -> bool:
	return transpose

func set_autotile_coord(position:Vector2) -> void:
	autotile_coord = position
func get_autotile_coord() -> Vector2:
	return autotile_coord

func _init(p_position, p_tile, p_flip_x=false, p_flip_y=false, p_transpose=false, p_autotile_coord=Vector2(0,0)):
	position = p_position
	tile = p_tile
	flip_x = p_flip_x
	flip_y = p_flip_y
	transpose = p_transpose
	autotile_coord = p_autotile_coord
