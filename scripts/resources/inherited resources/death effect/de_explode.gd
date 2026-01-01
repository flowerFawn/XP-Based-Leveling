extends DeathEffect
class_name DeathExplosion
##Shape of the explosion
@export var explosion_shape:Shape2D
##Damage done by the explosion
@export var explosion_damage:float
##The texture created when the explosion happens
@export var explosion_texture:Texture2D

func cause_effect(enemy:Enemy) -> void:
	var shapecast = create_shapecast(explosion_shape)
	shapecast.set_collision_mask_value(2, true)
	shapecast.set_collision_mask_value(1, true)
	shapecast.collide_with_bodies = true
	shapecast.target_position = Vector2.ZERO
	enemy.add_child(shapecast)
	await enemy.get_tree().physics_frame
	shapecast.force_shapecast_update()
	for body in get_shapecast_colliders(shapecast):
		if body is Enemy:
			body.take_damage(explosion_damage)
	create_visual_effect(explosion_texture, enemy.global_position)
