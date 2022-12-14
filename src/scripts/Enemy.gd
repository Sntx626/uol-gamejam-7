extends Node2D

const ENEMIES = [
	preload("res://objects/Bat.tscn"),
	preload("res://objects/BlueSlime.tscn")
]

var rng = RandomNumberGenerator.new()

func get_enemy() -> KinematicBody2D:
	return ENEMIES[randi() % 2].instance()
