extends KinematicBody2D


var velocity := Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y += 20
	move_and_slide(velocity);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass