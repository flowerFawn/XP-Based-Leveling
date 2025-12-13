extends Node

var player_position:Vector2 = Vector2.ZERO
var player:Player
var rnd = RandomNumberGenerator.new()
var projectile_holder:ProjectileHolder
var enemy_holder:Node2D
var player_level:int = 1
var closest_enemy_to_player_point:Vector2


func update_player_info(player:Player) -> void:
	player_position = player.global_position
