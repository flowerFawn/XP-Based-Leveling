extends MagicItem
class_name MIConductiveController

##The percentage (as a multiplier) damage per enemy. This is added together, then multiplied. Should not include the 1!
@export var percentage_increase_per_enemy:float

func _init() -> void:
	base_description = "A strange device that through it's conductivity, causes more damage the more enemies have been hit in the previous second"
	ability_name = "Conductive Controller"

func affect_outgoing_damage(prior_damage:float) -> float:
	print(prior_damage)
	print(prior_damage * (1 + (percentage_increase_per_enemy * MagicItemInfo.enemies_hit_this_second)))
	return prior_damage * (1 + (percentage_increase_per_enemy * MagicItemInfo.enemies_hit_this_second))
