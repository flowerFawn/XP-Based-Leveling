extends Spell
class_name SpellShard


func _init() -> void:
	ability_name = "Shard"
	base_description = "Shoots flurry of shards in all directions, randomly"

func cast() -> void:
	if not GameInfo.projectile_holder:
		return
	for n in range(projectile_count):
		shoot_shard()
		await spell_handler.get_tree().create_timer(multi_projectile_delay).timeout

func shoot_shard():
	GameInfo.projectile_holder.add_child(PlayerProjectile.new(projectile_speed, damage, shape, get_random_angle_vector(), texture, projectile_pierce))
