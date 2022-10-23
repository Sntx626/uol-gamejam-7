extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_parent().get_parent().get_node("level/player")
onready var experienceBar = $ExperienceBar/HBoxContainer/TextureProgress
onready var experienceLabel = $ExperienceBar/HBoxContainer/TextureProgress/Label
onready var levelLabel = $ExperienceBar/HBoxContainer/TextureRect/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	setExperienceBar()

func setExperienceBar():
	levelLabel.set_text(str(player.level))
	experienceBar.max_value = player.experience_req
	experienceBar.value = player.experience
	experienceLabel.set_text(str(player.experience * 100 / player.experience_req) + "%")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
