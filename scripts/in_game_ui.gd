extends Control
class_name InGameUI

@export var xp_progress:TextureProgressBar
@export var timer_label:Label
@export var dps_label:Label
@export var kill_count_label:Label
@export var level_label:Label

@export var animation_rect:AnimationRect
@export var tutorial:TextureButton

func _ready() -> void:
	if Config.show_tutorial:
		get_tree().paused = true
		tutorial.visible = true

func set_kill_counter(value:int):
	kill_count_label.text = "Kills:%02d" % value
	
	
func set_dps_counter(value:int):
	dps_label.text = "DPS:%02d" % value
	
func set_timer(time_elapsed:float):
	timer_label.text = "%02d:%02d" % [int(floor(time_elapsed / 60)), int(round(fmod(time_elapsed, 60)))]

func set_level_counter(value:int):
	level_label.text = "LV:%d" % value


func _on_texture_button_pressed() -> void:
	tutorial.visible = false
	get_tree().paused = false
	Config.show_tutorial = false
	Config.serialise()
	
func play_animation(animation:Array[Texture2D], fps:int = 2):
	animation_rect.sprites = animation
	animation_rect.fps = fps
	animation_rect.visible = true
	animation_rect.play_animation()
	await animation_rect.finished
	animation_rect.visible = false
