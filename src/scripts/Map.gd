extends Node


const Tile = preload("Tile.gd")

var tiles = []

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
	var tileset = JSON.parse(json)
	for tile in tileset:
		add_tile(
			Tile.new(
				Vector2(tileset["x"], tileset["y"]),
				tileset["tile"],
				tileset["flip_x"],
				tileset["flip_y"],
				tileset["transpose"],
				Vector2(
					tileset["autotile_coord_x"],
					tileset["autotile_coord_y"]
				)
			)
		)
	return self

func to_json():
	var tileset = []
	for tile in tiles:
		tileset.append({
			"x": tile.get_position().x,
			"y": tile.get_position().y,
			"tile": tile.get_tile(),
			"flip_x": tile.get_flip_x(),
			"flip_y": tile.get_flip_y(),
			"transpose": tile.get_transpose(),
			"autotile_coord_x": tile.get_autotile_coord().x,
			"autotile_coord_y": tile.get_autotile_coord().y
		})
	return JSON.print(tileset, "\t")
