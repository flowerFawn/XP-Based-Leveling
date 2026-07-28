extends Enemy
class_name EnemyAngry

var current_velocity:Vector2 = Vector2.ZERO

func do_movement(delta: float, all_enemies:Array[Enemy]) -> void:
	if dying or hitstopped:
		return
	current_velocity += (current_desired_direction * active_speed * delta)
	move(current_velocity * delta)
	print(current_velocity)
