extends EnemyMovementType
class_name EnemyMovementReverse
func get_enemy_direction(enemy_position:Vector2, player_position:Vector2) -> Vector2:
	var to_player:Vector2 = player_position - enemy_position
	if to_player.x ** 2 + to_player.y ** 2 > 5000 ** 2:
		return Vector2.ZERO
	else:
		return -(to_player.normalized())
