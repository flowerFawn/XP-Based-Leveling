extends Timer
class_name SpellHandler
var spell:Spell

#Done when it is initially created
func _init(new_spell:Spell) -> void:
	spell = new_spell
	connect("timeout", trigger_spell)

#Done after joining the scene tree, so the timer can be started
func _ready() -> void:
	await get_tree().physics_frame
	spell.initial_spell_setup()
	trigger_spell()
	if not spell.cooldown == 0:
		start(spell.cooldown)
	
func trigger_spell() -> void:
	spell.cast()
	
	
