extends EnemyMovementType
class_name EnemyMovementReverse
func get_enemy_direction(enemy_position:Vector2, player_position:Vector2) -> Vector2:
		return -(enemy_position.direction_to(player_position))
