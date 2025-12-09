extends Node2D

@export var projectile_holder:Node2D
@export var enemy_holder:Node2D
@export var game_controller:Node
@export var spell_option_menu:SpellOptionMenu

func _ready() -> void:
	GameInfo.projectile_holder = projectile_holder
	GameInfo.enemy_holder = enemy_holder
	SpellShop.spell_option_menu = spell_option_menu
	
