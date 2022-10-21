extends Node


export var knockback := 600
export var max_health := 3
export var health := 3

var level := 1
var experience := 0
var experience_req := 100

func _ready():
	experience = 0

func giveExp(amount):
	experience += amount
	while experience >= experience_req:
		experience -= experience_req
		LvlUp()

func LvlUp():
	print(level)
	level += 1
