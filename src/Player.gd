extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_speed := 100
export var gravity := 1500
export var acceleration := 2000
export var deacceleration := 2000
export var friction := 2000
export var current_friction := 2000
export var max_horizonzal_speed := 480
export var max_fall_speed := 1000
export var jump_height := -700

export var squash_speed := 0.01

var touching_ground := false
var touching_wall := false
var is_jumping := false
var air_jump_pressed := false
var coyote_time := false

var velocity := Vector2.ZERO
var motion := Vector2.ZERO
var UP := Vector2.UP

onready var ani = $AnimatedSprite
onready var ground_ray = $RayCastContainer/RayGround

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	check_ground_logic()
	handle_input(delta)
	do_physics(delta)
	pass
	
func check_ground_logic():
	if (touching_ground and !ground_ray.is_colliding()):
		touching_ground = true
		coyote_time = true
		yield(get_tree().create_timer(0.2), "timeout")
		coyote_time = false
	if (!touching_ground and ground_ray.is_colliding()):
		ani.scale = Vector2(1.2, 0.8)
	print(ground_ray.is_colliding())
	touching_ground = ground_ray.is_colliding()
	if (touching_ground):
		is_jumping = false
		motion.y = 0
		velocity.y = 0
	pass

func handle_input(var delta):
	handle_movement(delta)
	handle_jumping(delta)
	pass
	
func handle_movement(delta):
	if (Input.is_action_pressed("move_right")):
		if (velocity.x < -100):
			velocity.x += (deacceleration * delta)
			if(touching_ground):
				pass
		elif (velocity.x < max_horizonzal_speed):
			velocity.x += (acceleration * delta)
			ani.flip_h = true
			if (touching_ground):
				pass
		else:
			if (touching_ground):
				pass
	elif (Input.is_action_pressed("move_left")):
		if (velocity.x > 100):
			velocity.x -= (deacceleration * delta)
			if(touching_ground):
				pass
		elif (velocity.x > -max_horizonzal_speed):
			velocity.x -= (acceleration * delta)
			ani.flip_h = false
			if (touching_ground):
				pass
		else:
			if (touching_ground):
				pass
	else:
		if (touching_ground):
			velocity.x -= min(abs(velocity.x), current_friction * delta) * sign(velocity.x)
	pass

func handle_jumping(delta):
	if (coyote_time and Input.is_action_just_pressed("jump")):
		velocity.y = jump_height
		is_jumping = true
	if (touching_ground):
		if (Input.is_action_just_pressed("jump") or air_jump_pressed):
			velocity.y = jump_height
			touching_ground = false
			ani.scale = Vector2(0.5, 1.2)
	else:
		if (velocity.y < 0 and !Input.is_action_pressed("jump")):
			velocity.y = max(velocity.y, jump_height/2)
		if (Input.is_action_just_pressed("jump")):
			air_jump_pressed = true
			yield(get_tree().create_timer(0.2), "timeout")
			air_jump_pressed = false
	pass

func do_physics(var delta):
	if (is_on_ceiling()):
		motion.y = 10
		velocity.y = 10
		
	velocity.y += (gravity * delta)
	
	velocity.y = min(max_fall_speed, velocity.y)
	
	motion.x = velocity.x
	motion.y = velocity.y
	
	motion = move_and_slide(motion, UP)
	
	apply_squash_squeeze()
	pass
	
func apply_squash_squeeze():
	ani.scale.x = lerp(ani.scale.x,1,squash_speed)
	ani.scale.y = lerp(ani.scale.y,1,squash_speed)
