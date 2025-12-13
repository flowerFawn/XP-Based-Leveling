extends Node
class_name GameController

var enemy_count = 5

func update_directions() -> void:
	#updates enemies heading towards the player
	for enemy:Enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.update_direction()
	#updates where aimed spells will go
	if GameInfo.player:
		GameInfo.closest_enemy_to_player_point = GameInfo.player.get_closest_enemy()


func spawn_enemies() -> void:
	for enemy_to_spawn:int in range(0, enemy_count):
		spawn_enemy()
	enemy_count += 1
		
func spawn_enemy():
	const CAMERA_DISTANCE_VECTOR:Vector2 = Vector2(2350, 1350)
	var spawn_position:Vector2
	var spawn_offset:Vector2
	var player_position:Vector2 = GameInfo.player_position
	var neg_constant:int = [-1, 1][GameInfo.rnd.randi_range(0, 1)]
	var appears_from_centre:bool = [false, true][GameInfo.rnd.randi_range(0, 1)]
	if appears_from_centre:
		spawn_offset = Vector2(GameInfo.rnd.randi_range(-2300, 2300),neg_constant * CAMERA_DISTANCE_VECTOR.y)
	else:
		spawn_offset = Vector2(neg_constant * CAMERA_DISTANCE_VECTOR.x ,GameInfo.rnd.randi_range(-2300, 2300))
	spawn_position = player_position + spawn_offset
	var new_enemy:Enemy = Enemy.new_enemy(preload("uid://bg3osrk3a4ni5"))
	#var new_enemy:Enemy = Enemy.new_enemy(preload("uid://c6qqqoynid1fh"))
	#var new_enemy:Enemy = Enemy.new_enemy(preload("uid://dqunbnln7x2n0"))
	GameInfo.enemy_holder.add_child(new_enemy)
	new_enemy.global_position = spawn_position
