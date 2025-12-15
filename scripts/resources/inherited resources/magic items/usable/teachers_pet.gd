extends MagicItemCooldown
class_name MITeachersPet

func _init() -> void:
	base_description = "Protects you from harm, except when he is knocked out"
	ability_name = "Teacher's Pet"


func affect_incoming_damage(prior_damage:float) -> float:
	if not on_cooldown:
		start_cooldown(cooldown)
		print("Teachers Pet Activated")
		return 0
		#the "play teachers pet animation" code should be here also
	else:
		return prior_damage
