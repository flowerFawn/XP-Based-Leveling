extends Resource
class_name Spell
##Time in seconds between the cast being called. if this is set to 0, it will only be cast once
@export var cooldown:float

func cast(player:Player) -> void:
	print("A")


#region FOROTHERSPELLS
func get_shapecast_colliders(shapecast:ShapeCast2D) -> Array[Node2D]:
	var collider_array:Array[Node2D] = []
	for n in range(0, shapecast.get_collision_count()):
		collider_array.append(shapecast.get_collider(n))
	return collider_array
		

#endregion
