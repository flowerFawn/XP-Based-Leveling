extends Spell
class_name SpellSacredLight
##Projectile speed here is what controls the distance from the player!!!!
##I don't wanna make a new exported variable sorry....

##The total rotation changed by the sacred light before it disappears, in degrees
@export var rotation_change:float
##The total time the sacred light takes to reach it's final rotation
@export var rotation_time:float

var active_spell_rotators:Array[Node2D] = []

func _init() -> void:
	base_description = "A bright sacred light circles you, harming evil goblins caught in it's divine presence."
	ability_name = "Sacred Light"
	
func cast() -> void:
	var spell_rotator:Node2D = Node2D.new()
	var rotation_tween:Tween = spell_handler.create_tween()
	player.add_child(spell_rotator)
	for n in projectile_count:
		var new_projectile:PlayerProjectile = PlayerProjectile.new(0, damage, shape, Vector2.RIGHT, texture, 0, Vector2.ZERO, 0)
		spell_rotator.add_child(new_projectile)
		new_projectile.position = Vector2.RIGHT.rotated(deg_to_rad(GameInfo.rnd.randi_range(0, 360))) * projectile_speed
	rotation_tween.tween_property(spell_rotator, "rotation", deg_to_rad(rotation_change), rotation_time)
	active_spell_rotators.append(spell_rotator)
	await rotation_tween.finished
	active_spell_rotators.erase(spell_rotator)
	spell_rotator.queue_free()
	
func clean_up_for_removal() -> void:
	for rotator:Node2D in active_spell_rotators:
		rotator.queue_free()
