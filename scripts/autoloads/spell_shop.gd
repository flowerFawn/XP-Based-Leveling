extends Node

var spell_option_menu:SpellOptionMenu

var spell_xp:float = 0:
	set(value):
		spell_xp = value
		if spell_xp >= next_required_xp:
			spell_xp -= next_required_xp
			next_required_xp += 4
			call_deferred(&"award_spell_option")
var next_required_xp:float = 10
var current_spell_pool:Array[Spell] = [load("uid://7vmgb80p33sl"), 
load("uid://ciomfgvjduepp"), load("uid://dh4308dsgb1xc")]

##Not used outside of testing
func award_random_spell() -> void:
	#for now just fully random what spell you get
	if current_spell_pool.is_empty():
		return
	var new_spell:Spell = pop_random_spell()
	GameInfo.player.add_spell(new_spell)
	if new_spell.next_upgrade != null:
		add_spell_to_pool(new_spell.next_upgrade)
		
func get_random_spell() -> Spell:
	var picked_spell_index:int = GameInfo.rnd.randi_range(0, len(current_spell_pool) - 1)
	return current_spell_pool[picked_spell_index]
	
func pop_random_spell() -> Spell:
	var picked_spell_index:int = GameInfo.rnd.randi_range(0, len(current_spell_pool) - 1)
	return current_spell_pool.pop_at(picked_spell_index)
	
	
func add_spell_to_pool(spell:Spell) -> void:
	current_spell_pool.append(spell)
	
func _ready() -> void:
	await get_tree().process_frame
	award_spell_option()
	
func give_spell(spell:Spell):
	current_spell_pool.erase(spell)
	GameInfo.player.add_spell(spell)
	if spell.next_upgrade != null:
		add_spell_to_pool(spell.next_upgrade)
	
#currently always gives 3, maybe change the count?
func award_spell_option() -> void:
	spell_option_menu.show_spell_options([get_random_spell(), get_random_spell(), get_random_spell()])
