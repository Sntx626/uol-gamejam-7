extends TileMap

const Tile = preload("Tile.gd")
const Map = preload("Map.gd")
const Map_Loader = preload("Map_Loader.gd")
export(int) var _nav_tile_id := 10
var map_loader = Map_Loader.new()

func _ready():
	var map = Map.new()
	map_loader.save_map(map)
	var bounds_min := Vector2.ZERO
	var bounds_max := Vector2.ZERO
	for pos in get_used_cells():
		if pos.x < bounds_min.x:
			bounds_min.x = int(pos.x)
		elif pos.x > bounds_max.x:
			bounds_max.x = int(pos.x)
		if pos.y < bounds_min.y:
			bounds_min.y = int(pos.y)
		elif pos.y > bounds_max.y:
			bounds_max.y = int(pos.y)
	
	for x in range(bounds_min.x, bounds_max.x):
		for y in range(bounds_min.y, bounds_max.y):
			if get_cell(x, y) == -1:
				set_cell(x, y, 0, false, false, false, Vector2(3, 7))
	
	update_dirty_quadrants()

func _physics_process(delta):
	pass
