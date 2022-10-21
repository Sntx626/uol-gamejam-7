extends Node


export var knockback := 600
export var max_health := 3
var health = max_health

var level := 1
var experience := 0
var experience_a := 0
var experience_b := 100
var experience_req := 100

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
	level += 1
