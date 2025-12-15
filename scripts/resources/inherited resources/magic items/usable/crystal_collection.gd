extends MagicItem
class_name MICrystalCollection

##The MULTIPLIER that outgoing damage is multiplied by
@export var damage_increase:float = 1

func _init() -> void:
	base_description = "An assortment of crystals that boosts your magical damage. Through crystal-ness. And being sharp"
	ability_name = "Crystal Collection"
	
func affect_outgoing_damage(prior_damage:float) -> float:
	return prior_damage * damage_increase
