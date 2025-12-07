extends Spell
class_name SpellEarthquake

func cast(player:Player, spell_handler:SpellHandler) -> void:
	var shapecast:ShapeCast2D
	var shape:CircleShape2D = CircleShape2D.new()
	shape.radius = 200
	shapecast = create_shapecast(shape)
	player.add_child(shapecast)
	shapecast.force_shapecast_update()
	for enemy:Enemy in get_shapecast_colliders(shapecast):
		enemy.take_damage(4)
	shapecast.queue_free()
