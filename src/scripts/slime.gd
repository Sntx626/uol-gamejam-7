extends KinematicBody2D


var velocity := Vector2()
var direction := -1
export var health := 100
onready var ani = $AnimatedSprite
onready var ground_ray_cast = $GroundRayCast
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	direction = -1 if $AnimatedSprite.flip_h else 1
	
	ground_ray_cast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	pass # Replace with function body.


func _physics_process(delta):
	
	if (is_on_wall() or not ground_ray_cast.is_colliding()):
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		ground_ray_cast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	var dif = 50 * direction - velocity.x
	dif = min(50, abs(dif)) * sign(dif)
	velocity.x += dif
	velocity.y += 20
	velocity = move_and_slide(velocity, Vector2.UP);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	pass

export var exp_given := 50
func _on_Area2D_area_entered(area):
	if (area.is_in_group("Sword")):
		var sword = area.get_parent()
		if (sword.is_swinging):
			var knockpower = Vector2(sword.parent.stats.knockback, 0)
			knockpower = knockpower.rotated(position.angle_to_point(sword.get_parent().get_parent().position))
			#print(sword.get_parent().get_parent().position, "|", position)
			velocity = knockpower
			#print(knockpower)
			yield(blink(), "completed")
			health -= sword.parent.stats.attackDamage
			if (health <= 0):
				sword.get_parent().get_parent().stats.giveExp(exp_given)
				queue_free()
			
		
func blink():
	ani.visible = false
	yield(get_tree().create_timer(0.05), "timeout")
	ani.visible = true
	yield(get_tree().create_timer(0.07), "timeout")
	ani.visible = false
	yield(get_tree().create_timer(0.01), "timeout")
	ani.visible = true
