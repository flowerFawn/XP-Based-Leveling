extends Spell
class_name SpellMagicMissile

func _init() -> void:
	ability_name = "Magic Missile"
	base_description = "Shoots a bolt"

func cast() -> void:
	if not GameInfo.projectile_holder:
		return
	for n in range(projectile_count):
		shoot_bolt(n)
		await wait_time(multi_projectile_delay)

func shoot_bolt(n:int):
	GameInfo.projectile_holder.add_child(PlayerProjectile.new(
projectile_speed, damage, shape, get_direction_to_nearest_enemy(), texture, projectile_pierce, get_random_offset(clampi(n, 0, 1))))
