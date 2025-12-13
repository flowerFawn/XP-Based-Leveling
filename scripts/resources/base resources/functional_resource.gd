extends Resource
class_name FunctionalResource
##Class that contains useful functions others might need, so those functions don't need to be copy pasted

func create_shapecast(shape:Shape2D) -> ShapeCast2D:
	var shapecast = ShapeCast2D.new()
	shapecast.shape = shape
	shapecast.set_collision_mask_value(2, true)
	shapecast.collide_with_areas = true
	shapecast.collide_with_bodies = false
	shapecast.target_position = Vector2.ZERO
	return shapecast
	
func get_shapecast_colliders(shapecast:ShapeCast2D) -> Array[Node2D]:
	var collider_array:Array[Node2D] = []
	while shapecast.is_colliding():
		collider_array.append(shapecast.get_collider(0))
		shapecast.add_exception(shapecast.get_collider(0))
		shapecast.force_shapecast_update()
	shapecast.clear_exceptions()
	return collider_array
	
func create_visual_effect(sprite:Texture2D, global_position:Vector2, scale:float = 1, flipped = false, decay_time:float = 3) -> void:
	var effect_sprite:VisualEffectSprite = VisualEffectSprite.new()
	effect_sprite.texture = sprite
	effect_sprite.flip_h = flipped
	effect_sprite.scale = Vector2(scale, scale)
	GameInfo.projectile_holder.add_child(effect_sprite)
	effect_sprite.global_position = global_position
	effect_sprite.start_decay_timer(decay_time)
