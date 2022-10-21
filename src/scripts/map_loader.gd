extends Node


var Tile = load("rsc://scripts/Tile.gd")
var Map = load("rsc://scripts/Map.gd")

func load_map(name):
	var file = File.new()
	file.open("rsc://maps/" + name + ".json", File.READ)
	var content = file.get_as_text()
	file.close()

	var map = Map.new(name)
	map.from_json(content)

	return map

func save_map(map):
	var file = File.new()
	file.open("rsc://maps/" + name + ".json", File.WRITE)
	file.store_string(map.to_json())
	file.close()
