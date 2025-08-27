extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("EatAPerson")


func eatAGuy():
	SignalBus.emit_signal("eatThatGuy")
