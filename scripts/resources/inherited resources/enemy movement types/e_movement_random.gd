extends EnemyMovementType
class_name EnemyMovementRandom

func get_enemy_direction(enemy_position:Vector2, player_position:Vector2) -> Vector2:
	return Vector2.RIGHT.rotated(GameInfo.rnd.randf_range(0, 2 * PI))
