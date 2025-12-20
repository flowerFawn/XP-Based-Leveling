extends Spell
class_name SpellStaticSphere

var static_sphere_area:Area2D

func _init() -> void:
	base_description = "A crackling sphere of static electricity surrounds you, dealing damage to goblins that enter"
	ability_name = "Static Sphere"

func initial_spell_setup() -> void:
	static_sphere_area = Area2D.new()
	var static_sphere_shape = CollisionShape2D.new()
	var static_sphere_sprite = Sprite2D.new()
	static_sphere_sprite.texture = texture
	static_sphere_sprite.scale = Vector2(visual_scale, visual_scale)
	static_sphere_area = Area2D.new()
	static_sphere_shape.shape = shape
	static_sphere_area.add_child(static_sphere_shape)
	static_sphere_area.add_child(static_sphere_sprite)
	player.add_child(static_sphere_area)
	static_sphere_area.set_collision_mask_value(2, true)
	static_sphere_area.set_collision_layer_value(1, false)
	static_sphere_area.area_entered.connect(damage_in_sphere)
	
func cast() -> void:
	print(static_sphere_area.get_overlapping_areas())
	for enemy in static_sphere_area.get_overlapping_areas():
		damage_in_sphere(enemy)
		
func clean_up_for_removal() -> void:
	static_sphere_area.queue_free()

func damage_in_sphere(body:Area2D) -> void:
	if body.is_in_group(&"Enemy"):
		var harmed_enemy:Enemy = body
		harmed_enemy.take_damage(damage)
