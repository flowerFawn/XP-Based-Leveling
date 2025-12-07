extends Resource
class_name EnemyMovementType

##Replace this in children of the class to decide their movement pattern!
func get_enemy_direction(enemy_position:Vector2, player_position:Vector2) -> Vector2:
	return Vector2.ZERO
	


	
