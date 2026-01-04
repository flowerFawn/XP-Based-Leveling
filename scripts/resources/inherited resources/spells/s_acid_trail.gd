extends Spell
class_name SpellAcidtrail

##Time in seconds until the goop decays
@export var acid_decay_time:float

func _init():
	base_description = "Leaves a trail of acid behind you"
	ability_name = "Acid Trail"

func cast() -> void:
	for n:int in range(projectile_count):
		leave_goop(n)
		await wait_time(multi_projectile_delay)
		
func leave_goop(n:int) -> void:
	var new_goop:PlayerProjectile = PlayerProjectile.new(0, damage, shape, Vector2.ZERO, texture, projectile_pierce, get_random_offset(n), acid_decay_time)
	GameInfo.projectile_holder.add_child(new_goop)
