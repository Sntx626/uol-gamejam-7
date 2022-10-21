extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_speed := 100
export var gravity := 2000

var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed * delta
	if Input.is_action_pressed("move_left"):
		velocity.y -= move_speed * delta
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
