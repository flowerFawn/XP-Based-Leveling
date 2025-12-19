extends Spell
class_name SpellBolt

func _init() -> void:
	ability_name = "Bolt"
	base_description = "Shoots a bolt"

func cast() -> void:
	if not GameInfo.projectile_holder:
		return
	for n in range(projectile_count):
		shoot_bolt()
		await wait_time(multi_projectile_delay)

func shoot_bolt():
	GameInfo.projectile_holder.add_child(PlayerProjectile.new(projectile_speed, damage, shape, get_direction_to_nearest_enemy(), texture, projectile_pierce))
