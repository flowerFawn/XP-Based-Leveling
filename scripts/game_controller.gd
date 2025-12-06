extends Node




func update_enemy_directions() -> void:
	for enemy:Enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.update_direction()
