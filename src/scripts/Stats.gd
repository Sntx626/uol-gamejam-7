extends Node


export var max_health := 3
var health = max_health

export var attackSpeed = 50
export var attackDamage = 100
export var knockback := 600

export var level_progression := false
var level := 1
var experience := 0
var experience_a := 0
var experience_b := 100
var experience_req := 100

var parent

func set_parent(p):
	parent = p

func _ready():
	experience = 0

func giveExp(amount):
	experience += amount
	if experience >= experience_req:
		LvlUp()
		experience = 0
		experience_a = experience_b
		experience_b = experience_req
		experience_req = experience_a + experience_b
		print(experience_req)

func LvlUp():
	if level_progression:
		level += 1
		max_health += 0.5
		attackDamage = max(0.5, attackDamage-level)
		attackSpeed = max(int(attackSpeed/level), 10)
		health = min(health+max_health/level, max_health)
		parent.get_parent().level_difficulty *= 1.1
