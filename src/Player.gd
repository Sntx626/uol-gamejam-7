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
export var jump_height := -1000
export var knockback := 600

export var squash_speed := 0.05

var touching_ground := false
var touching_wall := false
var is_jumping := false
var air_jump_pressed := false
var coyote_time := false

var is_swinging := false

var velocity := Vector2.ZERO
var motion := Vector2.ZERO
var UP := Vector2.UP

onready var ani = $PlayerSprite
onready var aniArm = $Arm1
onready var ground_ray = $RayCastContainer/RayGround
onready var ground_ray2 = $RayCastContainer/RayGround2
onready var right_wall_ray = $RayCastContainer/RayWallRight
onready var left_wall_ray = $RayCastContainer/RayWallLeft

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	check_ground_logic()
	handle_input(delta)
	do_physics(delta)
	pass
	
func check_ground_logic():
	if (touching_ground and !(ground_ray.is_colliding() or ground_ray2.is_colliding())):
		touching_ground = true
		coyote_time = true
		yield(get_tree().create_timer(0.2), "timeout")
		coyote_time = false
	if (!touching_ground and (ground_ray.is_colliding() or ground_ray2.is_colliding())):
		ani.scale = Vector2(2.2, 1.6)
	touching_ground = (ground_ray.is_colliding() or ground_ray2.is_colliding())
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
			ani.flip_h = false
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
			ani.flip_h = true
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
			ani.scale = Vector2(1.6, 2.2)
	else:
		if (velocity.y < 0 and !Input.is_action_pressed("jump") and is_jumping):
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
	if (right_wall_ray.is_colliding()):
		velocity.x = min(velocity.x , 0)
	if (left_wall_ray.is_colliding()):
		velocity.x = max(velocity.x, 0)
	
	velocity.y += (gravity * delta)
	velocity.y = min(max_fall_speed, velocity.y)
	
	motion.x = velocity.x
	motion.y = velocity.y
	
	motion = move_and_slide(motion, UP)
	
	apply_squash_squeeze()
	pass
	
func apply_squash_squeeze():
	ani.scale.x = lerp(ani.scale.x,2,squash_speed)
	ani.scale.y = lerp(ani.scale.y,2,squash_speed)


func _on_Hurtbox_area_entered(area):
	if (area.is_in_group("hitbox")):
		var knockpower = Vector2(-knockback, 0)
		print(area.get_parent())
		knockpower = knockpower.rotated(position.angle_to_point(area.get_parent().position))
		knockpower *= Vector2(1, 1)
		knockpower *= -1
		velocity = knockpower
		blink()
		blink()
	pass # Replace with function body.
	
func blink():
	ani.visible = false
	yield(get_tree().create_timer(0.05), "timeout")
	ani.visible = true
	yield(get_tree().create_timer(0.07), "timeout")
	ani.visible = false
	yield(get_tree().create_timer(0.01), "timeout")
	ani.visible = true
	
