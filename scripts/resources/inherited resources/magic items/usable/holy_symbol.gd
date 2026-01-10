extends MagicItem
class_name MIHolySymbol

##This should be for when  gaining this specific level, not culminative
@export var flat_health_increase:int

func _init() -> void:
	base_description = "A holy symbol that raises your max hp"
	ability_name = "Holy Symbol"
	
func affect_player_stats(player:Player):
	player.max_health += flat_health_increase
	
	
