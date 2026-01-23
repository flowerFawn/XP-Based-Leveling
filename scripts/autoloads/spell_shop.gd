extends Node
var spell_option_menu:AbilityOptionMenu

var spell_xp:float = 0:
	set(value):
		spell_xp = value
		GameInfo.game_ui.xp_progress.value = spell_xp
		if spell_xp >= next_required_xp:
			spell_xp -= next_required_xp
			player_level += 1
			if player_level < 20:
				next_required_xp += 5
			else:
				next_required_xp += 10
			GameInfo.game_ui.set_level_counter(player_level)
			call_deferred(&"award_ability_option")
			GameInfo.game_ui.xp_progress.value = spell_xp
			GameInfo.game_ui.xp_progress.max_value = next_required_xp
var player_level = 1
var next_required_xp:float = 5
@export var current_ability_pool:Array[Ability]

var current_ability_weights:PackedFloat32Array

#saves processing time by calculating them ahead of time and storing them, because they're used a lot
const SQRT_ARRAY:Array[float] = [0, 
1, sqrt(2), sqrt(3), sqrt(4),
sqrt(5), sqrt(6), sqrt(7), sqrt(8), ]

#Not used outside of testing
#func award_random_spell() -> void:
	#for now just fully random what spell you get
	#if current_ability_pool.is_empty():
		#return
	#var new_spell:Spell = pop_random_ability()
	#GameInfo.player.add_spell(new_spell)
	#if new_spell.next_upgrade != null:
		#add_spell_to_pool(new_spell.next_upgrade)
		
func reset() -> void:
	next_required_xp = 5
	spell_xp = 0
	player_level = 1
	
		
#region SPELLONLY
		
###exclude_list should only ever include spells in the current spell pool. Hopefully. Unless you misuse it KRIS
##I don't think kris is ever going to touch the codebase lmao. It will be April who causes these issues (me).
##This is important because the detection for not having enough possible spells is based on length
func get_random_ability(exclude_list:Array[Ability] = []) -> Ability:
	if len(current_ability_pool) == 0 or len(exclude_list) >= len(current_ability_pool):
		print("Out of spells!!!!!!")
		return preload("uid://cg8ak1255fvmy")
	var non_duplicate:bool = false
	var picked_ability_index:int
	while not non_duplicate:
		picked_ability_index = GameInfo.rnd.rand_weighted(current_ability_weights)
		if not exclude_list.has(current_ability_pool[picked_ability_index]):
			non_duplicate = true
	return current_ability_pool[picked_ability_index]
	
func pop_random_ability() -> Ability:
	var picked_ability_index:int = GameInfo.rnd.randi_range(0, len(current_ability_pool) - 1)
	return current_ability_pool.pop_at(picked_ability_index)
	
	
func add_ability_to_pool(ability:Ability) -> void:
	current_ability_pool.append(ability)

	
func give_ability(ability:Ability):
	current_ability_pool.erase(ability)
	GameInfo.player.add_ability(ability)
	if ability.next_upgrade != null:
		add_ability_to_pool(ability.next_upgrade)
	
#currently always gives 3, maybe change the count?
func award_ability_option() -> void:
	spell_option_menu.show_random_ability_options()
	
func run_through_magic_items(value:Variant, method:StringName) -> Variant:
	var new_value = value
	if GameInfo.player:
		for magic_item in GameInfo.player.magic_items:
			if magic_item.has_method(method):
				new_value = magic_item.call(method, new_value)
		return new_value
	else:
		return value
	
func _ready() -> void:
	update_ability_weights()
	
func update_ability_weights() -> void:
	current_ability_weights = current_ability_pool.map(calculate_ability_rarity)

##Does the calculation for ability rarity. Believe it or not
## the negative reciprocal of r, multiplied by 0.05 multiplied by a quadratic with x as level (x-1)(x-8), all + 1
##1/r(x-1)(x-8) + 1
func calculate_ability_rarity(ability:Ability) -> float:
	return ((-1.0 / ability.rarity) * 0.05 * (ability.level - 1) * (ability.level - 8)) + 1
	
