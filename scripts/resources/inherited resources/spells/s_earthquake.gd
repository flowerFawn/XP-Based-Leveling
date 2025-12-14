extends Spell
class_name SpellEarthquake

func _init() -> void:
	ability_name = "Earthquake"
	base_description = "Creates a localised earthquake around you, damaging nearby enemies"

func cast(player:Player, spell_handler:SpellHandler) -> void:
	var shapecast:ShapeCast2D
	shapecast = create_shapecast(shape)
	player.add_child(shapecast)
	await spell_handler.get_tree().physics_frame
	shapecast.force_shapecast_update()
	for enemy:Enemy in get_shapecast_colliders(shapecast):
		enemy.take_damage(damage)
	create_visual_effect(texture, player.global_position, visual_scale)
	shapecast.queue_free()
