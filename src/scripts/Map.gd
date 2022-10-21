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
	
	if typeof(tileset.result) == TYPE_ARRAY:
		for tile in tileset.result:
			add_tile(
				Tile.new(
					Vector2(tile["x"], tile["y"]),
					tile["tile"],
					tile["flip_x"],
					tile["flip_y"],
					tile["transpose"],
					Vector2(
						tile["autotile_coord_x"],
						tile["autotile_coord_y"]
					)
				)
			)
		return self
	else:
		push_error("Unexpected results.")
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
