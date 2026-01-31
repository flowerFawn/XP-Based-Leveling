extends DeathEffect
class_name DeathSpawn

@export var enemy_to_spawn:EnemyType

func cause_effect(enemy:Enemy):
	GameInfo.game_controller.spawn_enemy(enemy_to_spawn, enemy.position)
