extends EnemyMovementType
class_name EnemyMovementBomber
var first_direction:Vector2 = Vector2.ZERO

func get_enemy_direction(enemy_position:Vector2, player_position:Vector2) -> Vector2:
	if first_direction.is_zero_approx():
		first_direction = enemy_position.direction_to(player_position)
	return first_direction
