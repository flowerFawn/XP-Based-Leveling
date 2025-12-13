extends Spell
class_name SpellWindSlash

func _init() -> void:
	spell_id = "Wind Slash"
	base_description = "Create a slash of wind"
	
func cast(player:Player, spell_handler:SpellHandler) -> void:
	do_slash(player, spell_handler)
	if level >= 2:
		do_slash(player, spell_handler, true)
		

func do_slash(player, spell_handler, other_direction:bool = false) -> void:
	var flip_again:int = 1
	var shapecast:ShapeCast2D = create_shapecast(shape)
	if other_direction:
		flip_again = -1
	shapecast.target_position.x = player.x_orientation * projectile_speed * flip_again
	player.add_child(shapecast)
	await spell_handler.get_tree().physics_frame
	shapecast.force_shapecast_update()
	for enemy:Enemy in get_shapecast_colliders(shapecast):
		print(enemy)
		enemy.take_damage(damage)
	shapecast.queue_free()
	var flipped_sprite:bool = player.x_orientation > 0
	if other_direction:
		flipped_sprite = not flipped_sprite
	create_visual_effect(texture, Vector2(player.global_position.x + (projectile_speed * 0.5 * player.x_orientation * flip_again), player.global_position.y), visual_scale, flipped_sprite)
