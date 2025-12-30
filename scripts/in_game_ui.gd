extends Control
class_name InGameUI

@export var xp_progress:TextureProgressBar
@export var timer_label:Label
@export var dps_label:Label
@export var kill_count_label:Label
@export var level_label:Label

func set_kill_counter(value:int):
	kill_count_label.text = "Kills:%02d" % value
	
	
func set_dps_counter(value:int):
	dps_label.text = "DPS:%02d" % value
	
func set_timer(time_elapsed:float):
	timer_label.text = "%02d:%02d" % [int(floor(time_elapsed / 60)), int(round(fmod(time_elapsed, 60)))]

func set_level_counter(value:int):
	level_label.text = "LV:%d" % value
