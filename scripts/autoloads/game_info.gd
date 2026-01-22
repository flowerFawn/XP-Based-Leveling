extends Node

var player_position:Vector2 = Vector2.ZERO
var player:Player
var rnd = RandomNumberGenerator.new()
var projectile_holder:ProjectileHolder
var game_controller:GameController
var game_ui:InGameUI
var pause_menu:PauseMenu
var enemy_handler:EnemyHandler
var player_level:int = 1
var closest_enemy_to_player_point:Vector2
var character:Character
var world_controller:WorldController
var enemy_damage_noises:Array[AudioStreamWAV] = [preload("uid://huu7uphlxx6g"), preload("uid://ypiuo0ayyvhm"), preload("uid://knmif14gpd45")]


func update_player_info(player:Player) -> void:
	player_position = player.global_position
	
	
##Returns a global position on the border of the camera, based on the player
func get_local_player_offset_position() -> Vector2:
	var spawn_offset:Vector2
	const CAMERA_DISTANCE_VECTOR:Vector2 = Vector2(2350, 1350)
	var neg_constant:int = [-1, 1][GameInfo.rnd.randi_range(0, 1)]
	var appears_from_centre:bool = [false, true][GameInfo.rnd.randi_range(0, 1)]
	if appears_from_centre:
		spawn_offset = Vector2(GameInfo.rnd.randi_range(-2300, 2300),neg_constant * CAMERA_DISTANCE_VECTOR.y)
	else:
		spawn_offset = Vector2(neg_constant * CAMERA_DISTANCE_VECTOR.x ,GameInfo.rnd.randi_range(-2300, 2300))
	return spawn_offset
	
func get_global_player_offset_position() -> Vector2:
	return player_position + get_local_player_offset_position()
