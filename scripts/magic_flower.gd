extends Area2D
class_name MagicFlower

@export var flower_sprite:Sprite2D

var effect:StringName

static var PRELOAD_INSTANCE:PackedScene = preload("uid://bt23ghxuadi2e")
static var bulb_colour_dict:Dictionary[StringName, Color] = {
	&"Heal":Color(0.0, 1.0, 0.0, 1.0),
	&"Magnet":Color(0.0, 0.0, 1.0, 1.0),
	&"Rush":Color(0.805, 0.467, 0.0, 1.0)}

static func create_flower(given_effect:StringName) -> MagicFlower:
	var new_flower:MagicFlower = PRELOAD_INSTANCE.instantiate()
	new_flower.effect = given_effect
	new_flower.flower_sprite.modulate = bulb_colour_dict[given_effect]
	return new_flower


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		visible = false
		await do_effect(body)
		queue_free()
		
func do_effect(player:Player) -> void:
	match effect:
		&"Heal":
			heal(player)
		&"Magnet":
			magnet(player)
		&"Rush":
			await rush(player)
			
func heal(player:Player):
	player.heal(20)
	
func magnet(player:Player):
	for xp_orb:XPOrb in get_tree().get_nodes_in_group(&"XPOrb"):
				xp_orb.be_picked_up(player)
				
func rush(player:Player):
	#otherwise could hit the bottom limit of 1% and so increase above original when reverting
	var original_cooldown:float = player.cooldown_multiplier
	player.cooldown_multiplier -= 0.6
	var difference:float = original_cooldown - player.cooldown_multiplier
	await get_tree().create_timer(5, false).timeout
	player.cooldown_multiplier += difference
