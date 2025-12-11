extends HBoxContainer
class_name SpellOptionMenu
const SPELL_OPTION_BOX:PackedScene = preload("uid://cs5x04qv7e47i")

func _input(event: InputEvent) -> void:
	pass

##The different spells will be unique
func show_random_spell_options(option_count:int = 3) -> void:
	get_tree().paused = true
	var new_spell_option_box:SpellOptionBox
	visible = true
	var spells_already_picked:Array[Spell]
	var spell:Spell
	for n in range(0, option_count):
		spell = SpellShop.get_random_spell(spells_already_picked)
		spells_already_picked.append(spell)
		new_spell_option_box = SPELL_OPTION_BOX.instantiate()
		new_spell_option_box.set_spell(spell)
		new_spell_option_box.spell_picked.connect(spell_chosen)
		add_child(new_spell_option_box)
	var first_box:SpellOptionBox = get_child(0)
	first_box.select_box()

func show_set_spell_options(spells:Array[Spell]):
	get_tree().paused = true
	var new_spell_option_box:SpellOptionBox
	visible = true
	for spell in spells:
		new_spell_option_box = SPELL_OPTION_BOX.instantiate()
		new_spell_option_box.set_spell(spell)
		new_spell_option_box.spell_picked.connect(spell_chosen)
		add_child(new_spell_option_box)
	var first_box:SpellOptionBox = get_child(0)
	first_box.select_box()
	
		
func spell_chosen(spell:Spell):
	for child in get_children():
		child.queue_free()
	SpellShop.give_spell(spell)
	visible = false
	get_tree().paused = false
