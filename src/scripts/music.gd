extends AudioStreamPlayer


var songs = [
	preload("../music/Lurking-Evil.mp3"),
	preload("../music/skeleton-carnival.mp3")
]
var counter = 0

func _ready():
	self.stream = songs[counter]
	self.volume_db = -20
	self.playing = true

func _physics_process(delta):
	if self.playing == false:
		self.stream = songs[counter%songs.size()]
		counter += 1
