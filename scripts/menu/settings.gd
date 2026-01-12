extends Control

@export var skip_check:CheckBox

@export var buffer_slider:HSlider
@export var buffer_slider_label:Label

func _ready():
	skip_check.button_pressed = Config.skip_intro
	buffer_slider.set_value(Config.input_buffer)

func _on_back_button_pressed() -> void:
	Config.serialise()
	get_tree().change_scene_to_packed(preload("uid://dj5n2ohldosah"))




func _on_skip_intro_check_toggled(toggled_on: bool) -> void:
	Config.skip_intro = toggled_on


func _on_buffer_slider_value_changed(value: float) -> void:
	Config.input_buffer = value
	buffer_slider_label.text = "Input Buffer: %.1f" % value
