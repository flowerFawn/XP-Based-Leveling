extends Spell
class_name SpellDart

##affects how the dart can turn
@export var dart_force:float

func cast() -> void:
	for n:int in range(projectile_count):
		shoot_dart(n)
		await wait_time(multi_projectile_delay)
		
func shoot_dart(n:int) -> void:
	if player:
		GameInfo.projectile_holder.add_child(HomingPlayerProjectile.new(projectile_speed, dart_force, damage, shape, get_random_angle_vector(), texture, projectile_pierce, get_random_offset(0), 0))
