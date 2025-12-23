extends Control

@export var skip_check:CheckBox

func _ready():
	skip_check.button_pressed = Config.skip_intro

func _on_back_button_pressed() -> void:
	Config.serialise()
	get_tree().change_scene_to_packed(preload("uid://dj5n2ohldosah"))




func _on_skip_intro_check_toggled(toggled_on: bool) -> void:
	Config.current_config.skip_intro = toggled_on
	print(toggled_on)
