extends Node

var spell_xp:float = 0:
	set(value):
		spell_xp = value
		if spell_xp >= next_required_xp:
			spell_xp -= next_required_xp
			next_required_xp += 4
			call_deferred(&"award_spell")
var next_required_xp:float = 10
var current_spell_pool:Array[Spell] = [load("uid://7vmgb80p33sl"), 
load("uid://ciomfgvjduepp"), load("uid://dh4308dsgb1xc")]

func award_spell() -> void:
	#for now just fully random what spell you get
	if current_spell_pool.is_empty():
		return
	var picked_spell_index:int = GameInfo.rnd.randi_range(0, len(current_spell_pool) - 1)
	var new_spell:Spell = current_spell_pool.pop_at(picked_spell_index)
	GameInfo.player.add_spell(new_spell)
	if new_spell.next_upgrade != null:
		add_spell_to_pool(new_spell.next_upgrade)
	
func add_spell_to_pool(spell:Spell) -> void:
	current_spell_pool.append(spell)
	
func _ready() -> void:
	await get_tree().process_frame
	award_spell()
