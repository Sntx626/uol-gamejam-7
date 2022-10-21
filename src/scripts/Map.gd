extends Node


var Tile = load("rsc://scripts/Tile.gd")

var tiles

func _ready():
	tiles = []

func get_size() -> int:
	var size = Vector2(0,0)
	for tile in tiles:
		if tile.position.x > size.x:
			size.x = tile.position.x
		if tile.position.y > size.y:
			size.y = tile.position.y
	return size

func get_tiles():
	return tiles

func add_tile(tile):
	tiles.append(tile)

func from_json(json):
	var temp = JSON.parse(json)
	for tile in temp:
		var t = Tile.new()
		t.set_tileset(tile["tileset"])
		t.set_position(Vector2(tile["x"], tile["y"]))
		add_tile(t)
	return self

func to_json():
	var temp = []
	for tile in tiles:
		temp.append({
			"tileset": tile.get_tileset(),
			"x": tile.get_position().x,
			"y": tile.get_position().y
		})
	return JSON.print(temp)
