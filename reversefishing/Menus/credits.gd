extends Node2D

@onready var sway_player: AnimationPlayer = $SwayPlayer
@onready var fade_player: AnimationPlayer = $FadePlayer
@onready var scroll_player: AnimationPlayer = $ScrollPlayer

func _ready() -> void:
	scroll_player.play("scroll")
	fade_player.play("FadeIn")
	sway_player.play("sway")

func _on_exit_button_up() -> void:
	fade_player.play("FadeOut")
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
