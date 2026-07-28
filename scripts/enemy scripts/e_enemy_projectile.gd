extends Enemy
class_name EnemyProjectile

var target_position:Vector2

func update_desired_direction() -> void:
	if current_desired_direction.is_zero_approx():
		current_desired_direction = enemy_type.movement_type.get_enemy_direction(global_position, GameInfo.player_position)
		target_position = GameInfo.player_position
		node_sprite.flip_h = global_position.x > GameInfo.player_position.x
