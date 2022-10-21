extends Node


class tile(Object):
	var pos:Vector2

	func new(position:Vector):
		pos = position

class map(Object):
	var tiles = []


func load_map():
    var file = File.new()
    file.open("user://save_game.dat", File.READ)
    var content = file.get_as_text()
    file.close()
    return content

func save_map():
    var file = File.new()
    file.open("user://save_game.dat", File.WRITE)
    file.store_string(content)
    file.close()
