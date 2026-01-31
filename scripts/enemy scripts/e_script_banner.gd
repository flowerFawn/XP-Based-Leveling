extends Enemy
class_name EnemyBanner

const GOBLINS_SPAWNED:int = 2

func misc_setup() -> void:
	GameInfo.game_controller.about_to_spawn.connect(spawn_goblins)
	
func spawn_goblins() -> void:
	for n in range(GOBLINS_SPAWNED):
		GameInfo.game_controller.spawn_enemy(preload("uid://bg3osrk3a4ni5"), position + get_random_offset())
		
func get_random_offset() -> Vector2:
	return Vector2(300, 0).rotated(randf_range(0, 2 * PI))
	
func begone() -> void:
	GameInfo.game_controller.about_to_spawn.disconnect(spawn_goblins)
	
