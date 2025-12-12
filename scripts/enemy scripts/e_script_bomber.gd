extends Enemy
class_name EnemyBomber

func update_direction() -> void:
	if current_direction.is_zero_approx():
		current_direction = enemy_type.movement_type.get_enemy_direction(global_position, GameInfo.player_position)

func misc_setup() -> void:
	const TIME_TILL_EXPLODES:float = 4.0
	var explode_timer:Timer = Timer.new()
	add_child(explode_timer)
	await explode_timer.tree_entered
	explode_timer.timeout.connect(die)
	explode_timer.start(TIME_TILL_EXPLODES)
