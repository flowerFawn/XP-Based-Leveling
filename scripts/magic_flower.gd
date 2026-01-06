extends Area2D
class_name MagicFlower

@export var flower_sprite:Sprite2D

var effect:StringName

static var PRELOAD_INSTANCE:PackedScene = preload("uid://bt23ghxuadi2e")
static var bulb_colour_dict:Dictionary[StringName, Color] = {
	&"Heal":Color(0.0, 1.0, 0.0, 1.0),
	&"Magnet":Color(0.0, 0.0, 1.0, 1.0)}

static func create_flower(given_effect:StringName) -> MagicFlower:
	var new_flower:MagicFlower = PRELOAD_INSTANCE.instantiate()
	new_flower.effect = given_effect
	new_flower.flower_sprite.modulate = bulb_colour_dict[given_effect]
	return new_flower


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		do_effect(body)
		queue_free()
		
func do_effect(player:Player) -> void:
	match effect:
		&"Heal":
			player.heal(20)
		&"Magnet":
			for xp_orb:XPOrb in get_tree().get_nodes_in_group(&"XPOrb"):
				xp_orb.be_picked_up(player)
