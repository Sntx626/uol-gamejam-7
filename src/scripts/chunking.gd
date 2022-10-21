extends TileMap

const Tile = preload("Tile.gd")
const Map = preload("Map.gd")
const Map_Loader = preload("Map_Loader.gd")
const DEFAULT_TTL = 10

var map_loader = Map_Loader.new()
var rng = RandomNumberGenerator.new()
var maps = [] # needs to contain at least one map!
var loaded_maps = {}

func _ready():
	clear()
	maps.append(map_loader.load_map("testing"))
	#manage_loaded_maps(1)

func _physics_process(delta):
	manage_loaded_maps(delta)

func save_current_map(name:String):
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

func manage_loaded_maps(delta):
	var current_level = get_parent().current_level
	for i in range(9):
		var current_relative_index = Vector2(int((i+1)%3), int((i+1)/3)) + Vector2(-1, -1)
		var level_loaded = false
		for level in loaded_maps.keys():
			if (level.x == current_relative_index.x and
				level.y == current_relative_index.y):
				level_loaded = true
		if !level_loaded:
			load_level(
				maps[rng.randi_range(0,maps.size()-1)],
				current_level + current_relative_index
			)
			print(current_level + current_relative_index)
	for level in loaded_maps.keys():
		loaded_maps[level][1] -= delta*100
	for level in loaded_maps.keys():
		# renew (active) loaded_maps
		if (level.x <= current_level.x + 1 and
			level.x >= current_level.x - 1 and
			level.y <= current_level.y + 1 and
			level.y >= current_level.y - 1):
				loaded_maps[level][1] = DEFAULT_TTL
	for level in loaded_maps.keys():
		if loaded_maps[level][1] <= 0:
			unload_level(level)

func load_level(map:Map, level:Vector2):
	var parent = get_parent()
	for tile in map.get_tiles():
		var pos = tile.get_position() + parent.level_dimensions * parent.level_scaling * level
		set_cellv(
			pos,
			tile.get_tile(),
			tile.get_flip_x(),
			tile.get_flip_y(),
			tile.get_transpose(),
			tile.get_autotile_coord() + get_parent().level_dimensions * level
		)
		update_bitmask_area(pos)
	loaded_maps[level] = [map, DEFAULT_TTL]

func unload_level(level:Vector2):
	var parent = get_parent()
	for tile in loaded_maps[level][0].get_tiles():
		set_cellv(
			tile.get_position() + get_parent().level_dimensions * parent.level_scaling * level,
			-1
		)
	loaded_maps.erase(level)
