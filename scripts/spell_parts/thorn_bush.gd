extends Area2D
class_name ThornBush

var damage:float


func _init(shape:Shape2D, given_damage:float, cooldown:float, time_till_decay:float, texture:Texture2D, texture_scale:float) -> void:
	var collision_node:CollisionShape2D = CollisionShape2D.new()
	var sprite_node:Sprite2D = Sprite2D.new()
	var harm_timer_node:Timer = Timer.new()
	set_collision_mask_value(2, true)
	set_collision_layer_value(1, false)
	damage = given_damage
	collision_node.shape = shape
	sprite_node.texture = texture
	sprite_node.scale = Vector2(texture_scale, texture_scale)
	harm_timer_node.wait_time = cooldown
	add_child(collision_node)
	add_child(sprite_node)
	add_child(harm_timer_node)
	harm_timer_node.autostart = true
	harm_timer_node.timeout.connect(damage_all_in_thorns)
	area_entered.connect(damage_in_thorns)
	end_of_setup(time_till_decay)

func end_of_setup(time_till_decay:float) -> void:
	await tree_entered
	damage_all_in_thorns()
	start_decay_timer(time_till_decay)
	
func damage_in_thorns(body:Node2D):
	if body is Enemy:
		var enemy:Enemy = body
		enemy.take_damage(damage)
		
func damage_all_in_thorns():
	for body in get_overlapping_areas():
		if body is Enemy:
			damage_in_thorns(body)
			
func start_decay_timer(time_till_decay:float) -> void:
	await get_tree().create_timer(time_till_decay).timeout
	queue_free()
