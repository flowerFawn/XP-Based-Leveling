extends Enemy
class_name EnemyBomber

var target_position:Vector2

func update_desired_direction() -> void:
	if current_desired_direction.is_zero_approx():
		current_desired_direction = enemy_type.movement_type.get_enemy_direction(global_position, GameInfo.player_position)
		target_position = GameInfo.player_position
	#if it has reached it's target position, hit the ground, and exploded
	if (target_position.x - global_position.x) ** 2 + (target_position.y - global_position.y) ** 2 < 80 ** 2:
		die()

func misc_setup() -> void:
	const TIME_TILL_EXPLODES:float = 4.0
	var explode_timer:Timer = Timer.new()
	add_child(explode_timer)
	await explode_timer.tree_entered
	explode_timer.timeout.connect(die)
	explode_timer.start(TIME_TILL_EXPLODES)
