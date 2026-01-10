extends HBoxContainer
class_name AbilityOptionMenu
const ability_OPTION_BOX:PackedScene = preload("uid://cs5x04qv7e47i")

func _input(event: InputEvent) -> void:
	pass

##The different abilitys will be unique
func show_random_ability_options(option_count:int = 4) -> void:
	get_tree().paused = true
	var new_ability_option_box:AbilityOptionBox
	get_parent().visible = true
	var abilities_already_picked:Array[Ability]
	var ability:Ability
	SpellShop.update_ability_weights()
	for n in range(0, option_count):
		ability = SpellShop.get_random_ability(abilities_already_picked)
		abilities_already_picked.append(ability)
		new_ability_option_box = ability_OPTION_BOX.instantiate()
		new_ability_option_box.set_ability(ability)
		new_ability_option_box.ability_picked.connect(spell_chosen)
		add_child(new_ability_option_box)
	var first_box:AbilityOptionBox = get_child(0)
	first_box.select_box()

func show_set_spell_options(abilities:Array[Ability]):
	get_tree().paused = true
	var new_ability_option_box:AbilityOptionBox
	visible = true
	for ability in abilities:
		new_ability_option_box = ability_OPTION_BOX.instantiate()
		new_ability_option_box.set_spell(ability)
		new_ability_option_box.spell_picked.connect(spell_chosen)
		add_child(new_ability_option_box)
	var first_box:AbilityOptionBox = get_child(0)
	first_box.select_box()
	
		
func spell_chosen(ability:Ability):
	for child in get_children():
		child.queue_free()
	SpellShop.give_ability(ability)
	get_parent().visible = false
	get_tree().paused = false
