extends VBoxContainer
class_name SpellOptionBox

signal spell_picked(spell:Spell)

@export var name_label:Label
@export var icon:TextureRect
@export var desc_label:Label
@export var button:Button
var represents_spell:Spell

func set_spell(spell:Spell):
	represents_spell = spell
	icon.texture = spell.texture

func _on_spell_button_pressed() -> void:
	emit_signal("spell_picked", represents_spell)
