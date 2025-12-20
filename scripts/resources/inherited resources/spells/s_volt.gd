extends Spell
class_name SpellVolt

func _init() -> void:
	base_description = "Creates a line of electrical energy that harms enemies it passes through"
	ability_name = "Volt"
	
func cast() -> void:
	for n in range(projectile_count):
		do_volt(n)

	
func do_volt(n:int) -> void:
	var new_raycast:RayCast2D = create_raycast()
	new_raycast.target_position = get_random_angle_vector() * projectile_speed
	player.add_child(new_raycast)
	await spell_handler.get_tree().physics_frame
	new_raycast.force_raycast_update()
	for enemy:Enemy in get_raycast_colliders(new_raycast):
		enemy.take_damage(damage)
	draw_line_from_player(new_raycast.target_position)
	new_raycast.queue_free()
		
##This should be a local position
func draw_line_from_player(end_position:Vector2) -> void:
	var line:VisualEffectLine = VisualEffectLine.new()
	line.add_point(Vector2.ZERO)
	line.add_point(end_position)
	line.width = 100
	line.texture = texture
	line.texture_mode = Line2D.LINE_TEXTURE_TILE
	line.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	GameInfo.projectile_holder.add_child(line)
	line.global_position = player.global_position
	line.start_decay_timer(1)
	
