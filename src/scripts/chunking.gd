extends TileMap

const Tile = preload("Tile.gd")
const Map = preload("Map.gd")
const Map_Loader = preload("Map_Loader.gd")

var map_loader = Map_Loader.new()

func _ready():
	var map = Map.new()
	map.name = "testing"
	
	for cell in get_used_cells():
		var t = Tile.new(
			cell,
			get_cellv(cell),
			is_cell_x_flipped(cell.x, cell.y),
			is_cell_y_flipped(cell.x, cell.y),
			is_cell_transposed(cell.x, cell.y),
			get_cell_autotile_coord(cell.x, cell.y)
		)
		map.add_tile(t)
	
	map_loader.save_map(map)

func _physics_process(delta):
	pass
