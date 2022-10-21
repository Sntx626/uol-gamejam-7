extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_parent().get_parent().get_node("level/player")
onready var experienceBar = $ExperienceBar/HBoxContainer/TextureProgress
onready var experienceLabel = $ExperienceBar/HBoxContainer/TextureProgress/Label
onready var levelLabel = $ExperienceBar/HBoxContainer/TextureRect/Label
onready var healthTexture = $ExperienceBar/HealthBar
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	setExperienceBar()

func setHealth():
	pass

func setExperienceBar():
	levelLabel.set_text(str(player.stats.level))
	experienceBar.value = player.stats.experience
	experienceBar.max_value = player.stats.experience_req
	experienceLabel.set_text(str(player.stats.experience * 100 / player.stats.experience_req) + "%")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
