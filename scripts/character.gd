extends CharacterBody2D
class_name Player
var speed:int = 500
var active_health:float = 100

func _physics_process(delta: float) -> void:
	var movement_vector = speed * get_direction()
	move_and_collide(movement_vector * delta)
	PlayerInfo.update_info(self)

	
func get_direction() -> Vector2:
	var direction:Vector2 = Vector2(Input.get_axis("player_left", "player_right"), Input.get_axis("player_up", "player_down")).normalized()
	direction = Vector2(direction.x * abs(Input.get_axis("player_left", "player_right")), direction.y * abs(Input.get_axis("player_up", "player_down")))
	return direction

#region HEALTH
func take_damage(amount:float) -> void:
	active_health -= amount
	if active_health <= 0:
		die()
		
func die():
	print("You died! sucks to suck buddy")
#endregion
