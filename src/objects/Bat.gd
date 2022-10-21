extends KinematicBody2D

export var speed = 150
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var path = []
var threshold = 16
var nav
export var health := 100
onready var ani = $AnimatedSprite

func init(owner):
	nav = owner.nav

func _physics_process(delta):
	if (path.size() > 0):
		move_to_target()
		
func move_to_target():
	if position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = position.direction_to(path[0])
		
		var goal = direction * speed
		var dif = goal - velocity
		dif.x = min(50, abs(dif.x)) * sign(dif.x)
		dif.y = min(50, abs(dif.y)) * sign(dif.y)
		velocity += dif 
		velocity = move_and_slide(velocity)
		
func get_target_path(target_pos):
	if nav:
		path = nav.get_simple_path(position, target_pos, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Area2D_area_entered(area):
	if (area.is_in_group("Sword")):
		var sword = area.get_parent()
		if (sword.is_swinging):
			var knockpower = Vector2(sword.knockback, 0)
			knockpower = knockpower.rotated(position.angle_to_point(sword.get_parent().get_parent().position))
			#print(sword.get_parent().get_parent().position, "|", position)
			velocity = knockpower
			#print(knockpower)
			yield(blink(), "completed")
			health -= sword.damage
			if (health <= 0):
				queue_free()
		
func blink():
	ani.visible = false
	yield(get_tree().create_timer(0.05), "timeout")
	ani.visible = true
	yield(get_tree().create_timer(0.07), "timeout")
	ani.visible = false
	yield(get_tree().create_timer(0.01), "timeout")
	ani.visible = true
