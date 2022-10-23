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
	setHealth()

var atlasHealthSize = Vector2(10, 10)

func setHealth():
	var healthProcent = 1-float(player.health)/player.max_health
	var index = int(healthProcent * 97)
	print(98*(index%10), "|", 96*(index/10))
	healthTexture.texture.region = Rect2(98*(index%10), 96*(index/10), 98, 96)

func setExperienceBar():
	levelLabel.set_text(str(player.level))
	experienceBar.max_value = player.experience_req
	experienceBar.value = player.experience
	experienceLabel.set_text(str(player.experience * 100 / player.experience_req) + "%")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
