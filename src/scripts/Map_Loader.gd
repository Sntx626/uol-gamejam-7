extends Node


const Tile = preload("Tile.gd")
const Map = preload("Map.gd")

const maps = {
	"simple":""
}

func load_map(name:String) -> Map:
	var map = Map.new()
	map.from_json(maps[name])
	return map

func load_maps() -> Array:
	var result = []
	for map in maps:
		var m = Map.new()
		result.append(m.from_json(map))
	return result

func save_map(map:Map) -> void:
	var file = File.new()
	file.open("rsc://maps/" + map.name + ".json", File.WRITE)
	file.store_string(map.to_json())
	file.close()
