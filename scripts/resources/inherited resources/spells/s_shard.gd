extends Spell
class_name SpellShard

func cast(player:Player, spell_handler:SpellHandler) -> void:
	if not GameInfo.projectile_holder:
		return
	var shape = CircleShape2D.new()
	shape.radius = 10
	var shard:PlayerProjectile = PlayerProjectile.new(150, 2, shape, get_random_angle_vector())
	GameInfo.projectile_holder.add_child(shard)
