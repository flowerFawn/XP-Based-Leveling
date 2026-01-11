extends Node2D
class_name ProjectileHolder
##position is global

func create_damage_label(label_position:Vector2, damage:int) -> void:
	var damage_color:Color = Color.WHITE
	if MagicItemInfo.damage_done_this_second >= GameInfo.player_level * 10:
		damage_color = Color.RED
	if MagicItemInfo.damage_done_this_second >= GameInfo.player_level * 20:
		damage_color = Color.CRIMSON
	if MagicItemInfo.damage_done_this_second >= GameInfo.player_level * 100:
		damage_color = Color.DARK_RED
	create_label(label_position, str(floori(damage)), damage_color)
	
func create_healing_label(label_position:Vector2, healing:int) -> void:
	create_label(label_position, str(floori(healing)), Color.WEB_GREEN)
	
func create_label(label_position:Vector2, text:String, color:Color) -> void:
	var damage_label:Label = Label.new()
	damage_label.set(&"theme_override_colors/font_color", color)
	
	damage_label.theme = preload("uid://dr8n3vxw1t7xv")
	damage_label.z_index = 4
	damage_label.text = text
	add_child(damage_label)
	damage_label.global_position = label_position
	var position_tween:Tween = create_tween()
	position_tween.set_ease(Tween.EASE_IN_OUT)
	position_tween.set_trans(Tween.TRANS_QUAD)
	var final_offset:Vector2 = Vector2(
		label_position.x + GameInfo.rnd.randi_range(-100, 100),
		label_position.y - GameInfo.rnd.randi_range(100, 150))
	position_tween.tween_property(damage_label, "global_position", final_offset, 1)
	await position_tween.finished
	damage_label.queue_free()
