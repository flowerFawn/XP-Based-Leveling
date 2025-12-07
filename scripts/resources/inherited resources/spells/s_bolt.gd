extends Spell
class_name SpellBolt
func cast(player:Player, spell_handler:SpellHandler) -> void:
	if not GameInfo.projectile_holder:
		return
	var shape = CircleShape2D.new()
	shape.radius = 30
	
	var bolt:PlayerProjectile = PlayerProjectile.new(50, 6, shape, get_direction_to_nearest_enemy())
	GameInfo.projectile_holder.add_child(bolt)
