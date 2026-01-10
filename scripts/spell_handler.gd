extends Timer
class_name SpellHandler
var spell:Spell

#Done when it is initially created
func _init(new_spell:Spell) -> void:
	spell = new_spell
	add_to_group(&"SpellHandler")
	connect("timeout", trigger_spell)

#Done after joining the scene tree, so the timer can be started
#now all done in the player side of things, to make updating cooldowns easier
#func _ready() -> void:
	#await get_tree().physics_frame
	#spell.initial_spell_setup()
	#trigger_spell()
	#if not spell.cooldown == 0:
		#start(spell.cooldown * GameInfo.)
	
func trigger_spell() -> void:
	await spell.cast()
	spell.emit_signal(&"finished_casting")
	
	
