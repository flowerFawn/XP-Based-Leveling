extends Node2D
class_name EnemyHandler

func _physics_process(delta: float) -> void:
	var all_enemies:Array[Enemy]
	all_enemies.assign(get_children())
	for enemy:Enemy in all_enemies:
		enemy.do_movement(delta, all_enemies)
