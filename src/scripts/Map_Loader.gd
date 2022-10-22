extends Node


const Tile = preload("Tile.gd")
const Map = preload("Map.gd")

func load_map(name:String) -> Map:
	var file = File.new()
	file.open("rsc://maps/" + name + ".json", File.READ)
	var content = file.get_as_text()
	file.close()
	var map = Map.new()
	map.from_json(content)
	return map

func save_map(map:Map) -> void:
	print("saving..\n", map.to_json())
	var file = File.new()
	file.open("rsc://maps/" + name + ".json", File.WRITE)
	file.store_string(map.to_json())
	file.close()
	print("saved..")
