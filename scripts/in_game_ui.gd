extends Control
class_name InGameUI

@export var xp_progress:TextureProgressBar
@export var timer_label:Label
@export var dps_label:Label
@export var kill_count_label:Label
@export var level_label:Label
@export var game_over_menu:GameOverMenu

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
	
func game_over() -> void:
	game_over_menu.game_finished()
	game_over_menu.offset_transform_position.y = -500
	var move_tween:Tween = create_tween()
	move_tween.set_trans(Tween.TRANS_ELASTIC)
	move_tween.set_ease(Tween.EASE_IN_OUT)
	move_tween.tween_property(game_over_menu, "offset_transform_position", Vector2(0, 0), 3)
	game_over_menu.visible = true


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
