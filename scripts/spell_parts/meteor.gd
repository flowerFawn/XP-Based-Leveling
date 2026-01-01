extends Area2D
class_name Meteor

var damage:float
var time_till_impact:float
var node_collision:CollisionShape2D
var node_sprite:Sprite2D

func _init(given_damage:float, given_shape:Shape2D, given_time_till_impact:float, sprite:Texture2D, sprite_scale:float = 1):
	damage = given_damage
	time_till_impact = given_time_till_impact
	node_collision = CollisionShape2D.new()
	node_collision.shape = given_shape
	node_sprite = Sprite2D.new()
	node_sprite.scale = Vector2(sprite_scale, sprite_scale)
	node_sprite.z_index = 20
	node_sprite.texture = sprite
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	add_child(node_collision)
	add_child(node_sprite)
	
func fall_at_point(fall_position:Vector2) -> void:
	global_position = fall_position
	node_sprite.position = GameInfo.get_local_player_offset_position() * 2
	node_sprite.scale = node_sprite.scale * 5
	node_sprite.modulate = Color.TRANSPARENT
	node_sprite.rotation = node_sprite.global_position.angle_to(fall_position)
	var sprite_tween:Tween = create_tween()
	sprite_tween.set_parallel(true)
	sprite_tween.tween_property(node_sprite, "modulate", Color.WHITE, time_till_impact / 2)
	sprite_tween.tween_property(node_sprite, "position", Vector2.ZERO, time_till_impact)
	sprite_tween.tween_property(node_sprite, "scale", node_sprite.scale / 5, time_till_impact)
	await sprite_tween.finished
	for body:Node2D in get_overlapping_areas():
		if body is Enemy:
			body.take_damage(damage)
	queue_free()
	
