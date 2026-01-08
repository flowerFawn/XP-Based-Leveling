extends Spell
class_name SpellFirebolt

func _init() -> void:
	base_description = "Shoots firebolts based on your orientations"
	ability_name = "Firebolt"

func cast() -> void:
	if not GameInfo.projectile_holder:
		return
	for n in range(projectile_count):
		shoot_firebolt(n)
		await spell_handler.get_tree().create_timer(multi_projectile_delay).timeout

func shoot_firebolt(n:int):
	if player:
		GameInfo.projectile_holder.add_child(PlayerProjectile.new(
			projectile_speed, damage, shape, player.accurate_orientation, texture, projectile_pierce, get_random_offset(clampi(n, 0, 1))))
