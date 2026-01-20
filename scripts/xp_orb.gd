extends Area2D
class_name XPOrb

var xp_value:float
var collision_node:CollisionShape2D
static var sprite:Texture2D = preload("uid://dqqbt1crw78ej")
static var pick_up_noise:AudioStreamWAV = preload("uid://dl7g12irdi3xl")

func _init(given_xp_amount:float):
	collision_node = CollisionShape2D.new()
	var sprite_node:Sprite2D = Sprite2D.new()
	var shape:Shape2D = CircleShape2D.new()
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, true)
	shape.radius = 50
	collision_node.shape = shape
	sprite_node.texture = sprite
	sprite_node.scale = Vector2(given_xp_amount / 2.0, given_xp_amount / 2.0)
	add_child(collision_node)
	add_child(sprite_node)
	body_entered.connect(be_picked_up)
	xp_value = given_xp_amount
	add_to_group(&"XPOrb")
	
func be_picked_up(body:Node2D) -> void:
	var pickup_tween:Tween = create_tween()
	#could be squared, but gets weird at long idstances
	var distance_to_player:float = global_position.distance_to(body.global_position)
	var original_global_position = global_position
	collision_node.queue_free()
	pickup_tween.set_trans(Tween.TRANS_BACK)
	get_parent().remove_child(self)
	GameInfo.player.add_child(self)
	global_position = original_global_position
	pickup_tween.tween_property(self, "position", Vector2.ZERO, distance_to_player * 0.00142)
	await pickup_tween.finished
	AudioHandler.play_sound(pick_up_noise, Vector2.ZERO, 2, 1)
	SpellShop.spell_xp += xp_value
	queue_free()
