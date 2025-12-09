extends Spell
class_name SpellShard

func cast(player:Player, spell_handler:SpellHandler) -> void:
	if not GameInfo.projectile_holder:
		return
	var shard:PlayerProjectile = PlayerProjectile.new(80, damage, shape, get_random_angle_vector(), texture)
	GameInfo.projectile_holder.add_child(shard)
