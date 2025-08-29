extends Node2D
@onready var fade_player: AnimationPlayer = $FadePlayer
@onready var sway_player: AnimationPlayer = $SwayPlayer
@onready var fade: Sprite2D = $Fade


func _ready() -> void:
	fade.visible = true
	fade_player.play("fadeIn")
	sway_player.play("sway")

func _on_play_button_up() -> void:
	fade_player.play("fadeOut")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Main/Main.tscn")

func _on_exit_button_up() -> void:
	fade_player.play("fadeOut")
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
