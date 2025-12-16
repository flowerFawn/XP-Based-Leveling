extends MagicItem
class_name MIBastionsAndBugbearsHandbook
@export var flat_damage_boost:int

func _init() -> void:
	base_description = "Adds a flat damage bonus"
	ability_name = "Bastions & Bugbears Handbook"

func affect_outgoing_damage(prior_damage:float) -> float:
	return prior_damage + flat_damage_boost
