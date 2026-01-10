extends Spell
class_name SpellMeteorShower

@export var time_till_impact:float
@export var explosion_texture:Texture2D

func _init():
	base_description = "Calls meteors from the sky, that fall on surrounding enemies"
	ability_name = "Meteor Shower"
	
func cast() -> void:
	if len(spell_handler.get_tree().get_nodes_in_group(&"Enemy")) <= 0:
		return
	for n:int in range(projectile_count):
		do_meteor(n, spell_handler.get_tree().get_nodes_in_group(&"Enemy"))
		await wait_time(multi_projectile_delay)
		
func do_meteor(n:int, possible_enemies:Array[Node]) -> void:
	#picked enemy isn't typed because I think that lets me assign it a previously freed instance?
	var picked_enemy:Enemy
	var aimed_position:Vector2
	var new_meteor:Meteor
	new_meteor = Meteor.new(damage, shape, time_till_impact, texture, visual_scale)
	picked_enemy = possible_enemies.pick_random()
	aimed_position = picked_enemy.global_position
	GameInfo.projectile_holder.add_child(new_meteor)
	await new_meteor.fall_at_point(aimed_position)
	create_visual_effect(explosion_texture, aimed_position, visual_scale * 2)
	
