extends EnemyMovementType
class_name EnemyMovementRotated
##Measured in degrees
@export var rotation_amount:float

func get_enemy_direction(enemy_position:Vector2, player_position:Vector2) -> Vector2:
	return (enemy_position.direction_to(player_position)).rotated(deg_to_rad(rotation_amount))
