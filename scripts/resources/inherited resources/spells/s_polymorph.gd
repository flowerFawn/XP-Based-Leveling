extends Spell
class_name SpellPolymorph
##Maximum power level of enemy this spell will affect
@export_range(1, 8) var max_power_affected:int

func _init():
	base_description = "Periodically turns enemies into harmless animals. Said animals do not give xp"
	ability_name = "Polymorph"
	
func cast() -> void:
	var transformations:Array[EnemyType] = [load("uid://ct458b2vvhlu2"), load("uid://cani8x5j71ma8")]
	var enemy_options:Array[Node] = spell_handler.get_tree().get_nodes_in_group(&"Enemy")
	var picked_enemies:Array[Enemy]
	var possible_new_enemy:Enemy
	var valid:bool = false
	var i:int = 0
	while len(picked_enemies) < min(projectile_count, len(enemy_options)) and i < len(enemy_options):
		if valid_to_polymorph(enemy_options[i], picked_enemies):
			picked_enemies.append(enemy_options[i])
		i += 1
	var transformation_type:EnemyType
	for enemy:Enemy in picked_enemies:
		transformation_type = transformations.pick_random()
		GameInfo.game_controller.spawn_specific_enemy(transformation_type, enemy.position)
		enemy.disappear(true)
		draw_line_from_player(enemy.global_position - player.global_position)

func valid_to_polymorph(enemy:Enemy, picked_enemies:Array[Enemy]) -> bool:
	if (not enemy in picked_enemies) and (enemy.enemy_type.power_level != 0) and (enemy.enemy_type.power_level <= max_power_affected) and (not enemy.enemy_type.harmless):
		return true
	return false
