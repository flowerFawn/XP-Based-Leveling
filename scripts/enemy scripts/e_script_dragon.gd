extends Enemy
class_name EnemyDragon

var time_elapsed:float

var n_spawns:int = 0

func misc_setup() -> void:
	GameInfo.game_controller.about_to_spawn.connect(spawn_magma)
	
func spawn_magma() -> void:
	n_spawns += 1
	GameInfo.game_controller.spawn_enemy(preload("uid://ccy2e7eroj01b"), position)
	if n_spawns % 3 == 0:
		GameInfo.game_controller.spawn_enemy(preload("uid://gsmbtnvv8tal"), position)
	for n in range(3):
		await get_tree().create_timer(0.5).timeout
		GameInfo.game_controller.spawn_enemy(preload("uid://ccy2e7eroj01b"), position)

	
func begone() -> void:
	GameInfo.game_controller.about_to_spawn.disconnect(spawn_magma)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_elapsed += delta
	active_speed = enemy_type.speed + sin(time_elapsed / 3) * 100
	
