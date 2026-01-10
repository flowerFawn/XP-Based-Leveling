extends MagicItem
class_name MICursedMirror

@export var extra_projectiles:int
@export var flat_damage_loss:int

func _init() -> void:
	base_description = "A cursed mirror that creates more projectiles, but weakens them"
	ability_name = "Cursed Mirror"

func affect_projectile_count(previous_count:int) -> int:
	previous_count += extra_projectiles
	if level >= 2:
		previous_count *= 2
	return previous_count

func affect_outgoing_damage(previous_count:float) -> float:
	if level <= 1:
		return previous_count - flat_damage_loss
	else:
		return previous_count / 2.0
