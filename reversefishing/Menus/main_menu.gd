extends Node2D


func _on_play_button_up() -> void:
	get_tree().change_scene_to_file("res://Main/Main.tscn")

func _on_exit_button_up() -> void:
	get_tree().exit()
