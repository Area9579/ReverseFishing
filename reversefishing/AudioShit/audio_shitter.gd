extends Node

@export var ambiance : AudioStreamPlayer
@export var rowboatCreaking : AudioStreamPlayer

func _process(_delta: float) -> void:
	if ambiance and !ambiance.playing:
		ambiance.play()


func _on_creaking_timer_timeout() -> void:
	rowboatCreaking.play()
