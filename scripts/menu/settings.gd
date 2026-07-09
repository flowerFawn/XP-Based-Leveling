extends Control

@export var skip_check:CheckBox


@export var screen_option:OptionButton

@export var show_quadtree_check:CheckBox

@export var show_tutorial_check:CheckBox


func _ready():
	skip_check.button_pressed = Config.skip_intro
	show_quadtree_check.button_pressed = Config.show_quadtree
	show_tutorial_check.button_pressed = Config.show_tutorial
	

func _on_back_button_pressed() -> void:
	Config.serialise()
	Config.update_based_on_config()
	get_tree().change_scene_to_packed(preload("uid://dj5n2ohldosah"))




func _on_skip_intro_check_toggled(toggled_on: bool) -> void:
	Config.skip_intro = toggled_on


func _on_fullscreen_option_item_selected(index: int) -> void:
	Config.screen_mode = screen_option.get_item_id(index)


func _on_show_quad_tree_check_toggled(toggled_on: bool) -> void:
	Config.show_quadtree = toggled_on


func _on_tutorial_check_toggled(toggled_on: bool) -> void:
	Config.show_tutorial = toggled_on
