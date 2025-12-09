extends HBoxContainer
class_name SpellOptionMenu
const SPELL_OPTION_BOX:PackedScene = preload("uid://cs5x04qv7e47i")

func show_spell_options(spells:Array[Spell]) -> void:
	get_tree().paused = true
	var new_spell_option_box:SpellOptionBox
	visible = true
	for spell:Spell in spells:
		new_spell_option_box = SPELL_OPTION_BOX.instantiate()
		new_spell_option_box.set_spell(spell)
		new_spell_option_box.spell_picked.connect(spell_chosen)
		add_child(new_spell_option_box)
		
func spell_chosen(spell:Spell):
	for child in get_children():
		child.queue_free()
	SpellShop.give_spell(spell)
	visible = false
	get_tree().paused = false
