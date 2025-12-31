extends Area2D
class_name XPOrb

var xp_value:float
var collision_node:CollisionShape2D
static var sprite:Texture2D = preload("uid://dqqbt1crw78ej")

func _init(given_xp_amount:float):
	collision_node = CollisionShape2D.new()
	var sprite_node:Sprite2D = Sprite2D.new()
	var shape:Shape2D = CircleShape2D.new()
	shape.radius = 50
	collision_node.shape = shape
	sprite_node.texture = sprite
	sprite_node.scale = Vector2(given_xp_amount / 2.0, given_xp_amount / 2.0)
	add_child(collision_node)
	add_child(sprite_node)
	body_entered.connect(be_picked_up)
	xp_value = given_xp_amount
	
func be_picked_up(body:Node2D) -> void:
	var pickup_tween:Tween = create_tween()
	collision_node.disabled = true
	pickup_tween.set_trans(Tween.TRANS_BACK)
	pickup_tween.tween_property(self, "global_position", GameInfo.player_position, 0.25)
	await pickup_tween.finished
	SpellShop.spell_xp += xp_value
	queue_free()
