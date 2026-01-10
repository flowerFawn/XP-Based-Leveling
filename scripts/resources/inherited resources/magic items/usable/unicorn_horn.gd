extends MagicItem
class_name MIUnicornHorn

##How much pierce is increased by
@export var increased_pierce:int

func _init():
	base_description = "A sharp unicorn horn that increases how many enemies spells can pierce"
	ability_name = "Unicorn Horn"
	
func affect_projectile_pierce(previous_count:int):
	return previous_count + increased_pierce
