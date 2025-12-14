extends VBoxContainer
class_name AbilityOptionBox

signal ability_picked(ability:Ability)

@export var name_label:Label
@export var icon:TextureRect
@export var desc_label:RichTextLabel
@export var button:Button
var represents_ability:Ability

func set_ability(ability:Ability):
	represents_ability = ability
	icon.texture = ability.icon
	name_label.text = "%s-(%s)" % [ability.ability_name, str(ability.level)]
	desc_label.text = ability.base_description + "\n" + ability.level_description

func _on_spell_button_pressed() -> void:
	emit_signal("ability_picked", represents_ability)

func select_box() -> void:
	button.grab_focus()
