extends Spell
class_name SpellEarthquake

func cast(player:Player) -> void:
	var shapecast:ShapeCast2D = ShapeCast2D.new()
	shapecast.shape = CircleShape2D.new()
	shapecast.shape.radius = 200
	shapecast.target_position = Vector2.ZERO
	shapecast.set_collision_mask_value(2, true)
	shapecast.collide_with_areas = true
	shapecast.collide_with_bodies = false
	player.add_child(shapecast)
	shapecast.force_shapecast_update()
	print("B")
	for enemy:Enemy in get_shapecast_colliders(shapecast):
		print("A")
		enemy.take_damage(4)
	shapecast.queue_free()
