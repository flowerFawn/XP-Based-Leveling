extends VBoxContainer
class_name SpellOptionBox

signal spell_picked(spell:Spell)

@export var name_label:Label
@export var icon:TextureRect
@export var desc_label:RichTextLabel
@export var button:Button
var represents_spell:Spell

func set_spell(spell:Spell):
	represents_spell = spell
	icon.texture = spell.icon
	name_label.text = "%s-(%s)" % [spell.spell_id, str(spell.level)]
	desc_label.text = spell.base_description + "\n" + spell.level_description

func _on_spell_button_pressed() -> void:
	emit_signal("spell_picked", represents_spell)

func select_box() -> void:
	button.grab_focus()
