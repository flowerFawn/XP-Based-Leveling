extends MagicItem
class_name MIMagicalRevolver

##The amount of extra projectiles created
@export var extra_projectiles:int = 1

func _init() -> void:
	base_description = "A magical firearm, that through the ancient art of fanning the hammer, 
	increases how many projectiles you can create in a single casting of a spell"
	ability_name = "Magical Revolver"
	
func affect_projectile_count(previous_count:int) -> int:
	return previous_count + extra_projectiles
