extends MagicItem
class_name MIFlowerCrown

@export var flower_multiplier_change:float

func _init() -> void:
	base_description = "A flower crown that causes more magical flowers to sprout in your presence"
	ability_name = "Flower Crown"
	
func affect_player_stats(player:Player) -> void:
	player.flower_multiplier += flower_multiplier_change
