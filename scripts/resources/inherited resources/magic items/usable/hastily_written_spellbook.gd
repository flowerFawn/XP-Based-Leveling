extends MagicItem
class_name MIHastySpellBook

##The change to the percentage of cooldowns is flat. This should not include the one, and is not culminative of lower levels
@export var flat_percentage_decrease:float

func _init() -> void:
	base_description = "A quickly scrawled spellbook, which decreases your spell cooldowns"
	ability_name = "Hastily Written Spellbook"
	
func affect_player_stats(player:Player) -> void:
	player.cooldown_multiplier -= flat_percentage_decrease
