extends Resource
class_name Spell
##Time in seconds between the cast being called. if this is set to 0, it will only be cast once
@export var cooldown:float

func cast(player:Player, spell_handler:SpellHandler) -> void:
	print("A")


#region USEFUL SPELL FUNCTIONS
func get_shapecast_colliders(shapecast:ShapeCast2D) -> Array[Node2D]:
	var collider_array:Array[Node2D] = []
	for n in range(0, shapecast.get_collision_count()):
		collider_array.append(shapecast.get_collider(n))
	return collider_array
	
func create_shapecast(shape:Shape2D) -> ShapeCast2D:
	var shapecast = ShapeCast2D.new()
	shapecast.shape = shape
	shapecast.set_collision_mask_value(2, true)
	shapecast.collide_with_areas = true
	shapecast.collide_with_bodies = false
	shapecast.target_position = Vector2.ZERO
	return shapecast
	
func get_random_angle_vector() -> Vector2:
	return Vector2.RIGHT.rotated(randi_range(0, 2 * PI))
	
func get_direction_to_nearest_enemy() -> Vector2:
	return GameInfo.player_position.direction_to(GameInfo.closest_enemy_to_player_point)

#endregion
