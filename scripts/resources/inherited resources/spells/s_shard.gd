extends Spell
class_name SpellShard


func _init() -> void:
	spell_id = "Shard"
	base_description = "Shoots flurry of shards in all directions, randomly"

func cast(player:Player, spell_handler:SpellHandler) -> void:
	if not GameInfo.projectile_holder:
		return
	for n in range(projectile_count):
		shoot_shard()
		await spell_handler.get_tree().create_timer(multi_projectile_delay)

func shoot_shard():
	GameInfo.projectile_holder.add_child(PlayerProjectile.new(projectile_speed, damage, shape, get_random_angle_vector(), texture))
