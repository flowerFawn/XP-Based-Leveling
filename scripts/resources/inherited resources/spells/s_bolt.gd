extends Spell
class_name SpellBolt

func _init() -> void:
	spell_id = "Bolt"
	base_description = "Shoots a bolt"

func cast(player:Player, spell_handler:SpellHandler) -> void:
	if not GameInfo.projectile_holder:
		return
	for n in range(projectile_count):
		shoot_bolt()

func shoot_bolt():
	GameInfo.projectile_holder.add_child(PlayerProjectile.new(projectile_speed, damage, shape, get_direction_to_nearest_enemy(), texture, projectile_pierce))
