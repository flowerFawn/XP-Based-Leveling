extends MagicItem
class_name MIWingedBoots

##This should be for when gaining this specific level, not culminative
@export var speed_increase:int

func affect_player_stats(player:Player) -> void:
	player.speed += speed_increase
