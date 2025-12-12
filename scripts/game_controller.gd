extends Node


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
	var spawn_position:Vector2 = GameInfo.player_position
	while spawn_position.distance_squared_to(GameInfo.player_position) < 300 ** 2:
		spawn_position = Vector2(GameInfo.rnd.randi_range(GameInfo.player_position.x - 1000, GameInfo.player_position.x + 1000),
		GameInfo.rnd.randi_range(GameInfo.player_position.y - 1000, GameInfo.player_position.y + 1000))
	#var new_enemy:Enemy = Enemy.new_enemy(preload("uid://bg3osrk3a4ni5"))
	var new_enemy:Enemy = Enemy.new_enemy(preload("uid://c6qqqoynid1fh"))
	#var new_enemy:Enemy = Enemy.new_enemy(preload("uid://dqunbnln7x2n0"))
	GameInfo.enemy_holder.add_child(new_enemy)
	new_enemy.global_position = spawn_position
