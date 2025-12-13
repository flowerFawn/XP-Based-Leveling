extends Spell
class_name SpellShard


func _init() -> void:
	spell_id = "Shard"
	base_description = "Shoots flurry of shards in all directions, randomly"

func cast(player:Player, spell_handler:SpellHandler) -> void:
	if not GameInfo.projectile_holder:
		return
	var shard:PlayerProjectile = PlayerProjectile.new(projectile_speed, damage, shape, get_random_angle_vector(), texture)
	GameInfo.projectile_holder.add_child(shard)
