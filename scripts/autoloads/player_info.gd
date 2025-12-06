extends Node

var player_position:Vector2 = Vector2.ZERO

func update_info(player:Player) -> void:
	player_position = player.global_position
