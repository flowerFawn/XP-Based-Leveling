extends Spell
class_name SpellArcLightning

func _init():
	base_description = "Shoots out lightning that arcs from enemy to enemy"
	ability_name = "Arc Lightning"
	
func cast() -> void:
	var remaining_possible_arcs:int = projectile_pierce
	var possible_targets:Dictionary[Enemy, Vector2]
	
	var arc_shapecast:ShapeCast2D
	
	var arc_start:Vector2
	var arc_affected_enemy:Enemy
	possible_targets[player.get_closest_enemy()] = player.global_position
	if possible_targets.keys()[0] == null:
		return
	for n in range(remaining_possible_arcs):
		if n <= remaining_possible_arcs and n < len(possible_targets):
			arc_affected_enemy = possible_targets.keys()[n]
			arc_start = possible_targets[arc_affected_enemy]
			draw_line_between_points(arc_start, arc_affected_enemy.global_position - arc_start, 100, 2)
			arc_affected_enemy.take_damage(damage)
			arc_shapecast = create_shapecast(shape)
			player.add_child(arc_shapecast)
			arc_shapecast.global_position = arc_affected_enemy.global_position
			await spell_handler.get_tree().physics_frame
			arc_shapecast.force_shapecast_update()
			for enemy:Node2D in get_shapecast_colliders(arc_shapecast):
				if enemy is Enemy and not enemy in possible_targets.keys():
					var arced_to_enemy:Enemy = enemy
					possible_targets[arced_to_enemy] = arc_affected_enemy.global_position
			arc_shapecast.queue_free()
			remaining_possible_arcs -= 1
			await wait_time(multi_projectile_delay)
