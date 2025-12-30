extends Node
##Contains information certain magic items way want to know, and can reference from here.
##Also contains the functions used to keep track of these
##for example removing an addition to a value after a certain amount of time

var enemies_hit_this_second:int = 0
var total_enemies_killed:int = 0

func register_enemy_hit_this_second() -> void:
	enemies_hit_this_second += 1
	await get_tree().create_timer(1).timeout
	enemies_hit_this_second -= 1

func register_kill() -> void:
	total_enemies_killed += 1
	GameInfo.game_ui.set_kill_counter(total_enemies_killed)
