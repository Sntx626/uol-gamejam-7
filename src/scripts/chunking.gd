extends TileMap

const Tile = preload("Tile.gd")
const Map = preload("Map.gd")
const Map_Loader = preload("Map_Loader.gd")

var map_loader = Map_Loader.new()

func _ready():
	var map = Map.new()
	map_loader.save_map(map)

func _physics_process(delta):
	pass
