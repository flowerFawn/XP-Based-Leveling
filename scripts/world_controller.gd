extends Node2D
class_name WorldController
@export var projectile_holder:ProjectileHolder
@export var enemy_holder:Node2D
@export var game_controller:GameController
@export var game_ui:InGameUI
@export var pause_menu:PauseMenu
@export var spell_option_menu:AbilityOptionMenu

func _ready() -> void:
	GameInfo.world_controller = self
	GameInfo.projectile_holder = projectile_holder
	GameInfo.enemy_holder = enemy_holder
	GameInfo.game_ui = game_ui
	GameInfo.game_controller = game_controller
	SpellShop.spell_option_menu = spell_option_menu
	game_ui.xp_progress.max_value = SpellShop.next_required_xp
	MagicItemInfo.reset()
	SpellShop.reset()

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		get_tree().paused = true
		pause_menu.visible = true
		await pause_menu.unpause
		get_tree().paused = false
		pause_menu.visible = false
