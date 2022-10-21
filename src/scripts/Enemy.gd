extends Node2D

const ENEMIES = [
	preload("res://objects/Bat.tscn"),
	preload("res://objects/BlueSlime.tscn")
]

var rng = RandomNumberGenerator.new()

func get_enemy() -> KinematicBody2D:
	return ENEMIES[rng.randi_range(0, ENEMIES.size()-1)].instance()
