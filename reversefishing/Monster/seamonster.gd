extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var splash: AudioStreamPlayer3D = $Splash


func _ready() -> void:
	animation_player.play("EatAPerson")
	splash.play()
	splash.reparent(get_tree().current_scene)


func eatAGuy():
	SignalBus.emit_signal("eatThatGuy")
