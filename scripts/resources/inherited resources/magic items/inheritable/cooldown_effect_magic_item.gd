extends MagicItem
class_name MagicItemCooldown

var on_cooldown:bool = false

##The length after triggering that the cooldown will last
@export var cooldown:float

func start_cooldown(time:float):
	on_cooldown = true
	await GameInfo.get_tree().create_timer(time).timeout
	on_cooldown = false
