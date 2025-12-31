extends Control
class_name PauseMenu

signal unpause

func _on_play_button_pressed() -> void:
	emit_signal("unpause")


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(load("uid://dj5n2ohldosah"))
