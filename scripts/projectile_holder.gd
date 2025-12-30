extends Node2D
class_name ProjectileHolder
##position is global
var damage_done_this_second:int = 0

func create_damage_label(label_position:Vector2, damage:int) -> void:
	#damage marker
	var damage_label:Label = Label.new()
	
	damage_done_this_second += damage
	damage_label.theme = preload("uid://dr8n3vxw1t7xv")
	damage_label.z_index = 4
	damage_label.text = str(floori(damage))
	add_child(damage_label)
	if damage_done_this_second >= GameInfo.player_level * 10:
		damage_label.set(&"theme_override_colors/font_color", Color.RED)
	if damage_done_this_second >= GameInfo.player_level * 20:
		damage_label.set(&"theme_override_colors/font_color", Color.CRIMSON)
	if damage_done_this_second >= GameInfo.player_level * 100:
		damage_label.set(&"theme_override_colors/font_color", Color.DARK_RED)
	damage_label.global_position = label_position
	var position_tween:Tween = create_tween()
	position_tween.set_ease(Tween.EASE_IN_OUT)
	position_tween.set_trans(Tween.TRANS_QUAD)
	var final_offset:Vector2 = Vector2(
		label_position.x + GameInfo.rnd.randi_range(-100, 100),
		label_position.y - GameInfo.rnd.randi_range(100, 150))
	position_tween.tween_property(damage_label, "global_position", final_offset, 1)
	GameInfo.game_ui.set_dps_counter(damage_done_this_second)
	await position_tween.finished
	damage_done_this_second -= damage
	damage_label.queue_free()
	GameInfo.game_ui.set_dps_counter(damage_done_this_second)
	
