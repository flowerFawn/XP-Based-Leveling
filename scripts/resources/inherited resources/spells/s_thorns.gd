extends Spell
class_name SpellThorns

##The time between each individual thorn bush damaging creatures within it
@export var thorn_bush_trigger_timer:float
##The time before a thorn bush is destroyed after being created
@export var thorn_bush_decay_time:float

func _init() -> void:
	base_description = "Creates thorn bushes around your feet, that stay in place and damage enemies that pass through them"
	ability_name = "Thorn Bush"


func cast() -> void:
	var new_thorn_bush:ThornBush = ThornBush.new(shape, damage, thorn_bush_trigger_timer, thorn_bush_decay_time, texture, visual_scale)
	GameInfo.projectile_holder.add_child(new_thorn_bush)
	new_thorn_bush.global_position = player.global_position
