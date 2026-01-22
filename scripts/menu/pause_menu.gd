extends Control
class_name PauseMenu

@export var magic_item_icon_container:VBoxContainer
@export var spell_icon_container:VBoxContainer

signal unpause

func _on_play_button_pressed() -> void:
	emit_signal("unpause")


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	GameInfo.player.die()

func add_ability_icon(ability:Ability) -> AbilityIcon:
	var ability_icon:AbilityIcon = AbilityIcon.new_ability_icon(ability.icon, ability.level)
	if ability is Spell:
		spell_icon_container.add_child(ability_icon)
	if ability is MagicItem:
		magic_item_icon_container.add_child(ability_icon)
	return ability_icon
	
