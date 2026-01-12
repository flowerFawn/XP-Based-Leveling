extends Node
##Contains information certain magic items way want to know, and can reference from here.
##Also contains the functions used to keep track of these
##for example removing an addition to a value after a certain amount of time

var enemies_hit_this_second:int = 0
var total_enemies_killed:int = 0
var damage_done_this_second:int = 0

func reset() -> void:
	enemies_hit_this_second = 0
	total_enemies_killed = 0

func register_enemy_hit_this_second() -> void:
	enemies_hit_this_second += 1
	await get_tree().create_timer(1, false).timeout
	enemies_hit_this_second -= 1
	
func register_damage_done(amount:float) -> void:
	if GameInfo.game_ui:
		damage_done_this_second += amount
		GameInfo.game_ui.set_dps_counter(damage_done_this_second)
		await get_tree().create_timer(1, false).timeout
		damage_done_this_second -= amount
		GameInfo.game_ui.set_dps_counter(damage_done_this_second)


func register_kill() -> void:
	total_enemies_killed += 1
	GameInfo.game_ui.set_kill_counter(total_enemies_killed)
