extends MagicItem
class_name MIWingedBoots

##This should be for when gaining this specific level, not culminative
@export var speed_increase:int

func _init():
	ability_name = "Winged Boots"
	base_description = "Increases speed"

func affect_player_stats(player:Player) -> void:
	player.speed += speed_increase
