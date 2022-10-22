extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.

export var attackSpeed = 10
export var attackDamage = 10

var is_swinging := false


onready var parentAni = get_parent().get_node("PlayerSprite")
onready var sword := $Sword

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if (not flip_h == parentAni.flip_h):
		flip_h = parentAni.flip_h
		offset.x = offset.x * -1
		if (sword):
			sword.position.x = sword.position.x * -1
	print()
	rotate(get_angle_to(get_global_mouse_position())+deg2rad(180 if flip_h else -0))

func _physics_process(delta):
	handle_sword(delta)

func handle_sword(var delta):
	if (not is_swinging and Input.is_action_just_pressed("hit")):
		print("Swing")
		is_swinging = true
		speed_scale = attackSpeed/10
		play("hit")
		yield(self, "animation_finished")
		play("idle")
		is_swinging = false
	
