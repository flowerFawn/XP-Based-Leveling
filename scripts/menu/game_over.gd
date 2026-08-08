extends Control
class_name GameOverMenu

@export var stats_label:Label

const STATS_LAYOUT:String = "Time:%02d:%02d\nKills:%s\nWell done!"

func game_finished() -> void:
	var time:float = GameInfo.game_controller.time_elapsed
	stats_label.text = STATS_LAYOUT % [int(floor(time / 60)),
	int(round(fmod(time, 60))),
	MagicItemInfo.total_enemies_killed]

func back_to_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("uid://dj5n2ohldosah")
