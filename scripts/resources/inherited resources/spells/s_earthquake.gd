extends Spell
class_name SpellEarthquake

func cast(player:Player, spell_handler:SpellHandler) -> void:
	var shapecast:ShapeCast2D
	shapecast = create_shapecast(shape)
	player.add_child(shapecast)
	shapecast.force_shapecast_update()
	for enemy:Enemy in get_shapecast_colliders(shapecast):
		enemy.take_damage(4)
	create_visual_effect(texture, player.global_position, visual_scale)
	shapecast.queue_free()
