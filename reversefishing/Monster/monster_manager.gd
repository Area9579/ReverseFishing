extends Node3D

var monster : PackedScene = preload("res://Monster/seamonster.tscn")


func _ready() -> void:
	SignalBus.connect("spawnMonster", spawnMonster)


func spawnMonster(preserver):
	var newMonster = monster.instantiate()
	preserver.add_child(newMonster)
	newMonster.reparent(self)
