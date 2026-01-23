extends Ability
class_name Spell
##The resource used for spells that are repeatedly cast as attacks. Contains the functions to cast the spell.
##These variables tend to be used differently by different spells, and not all fields will be used by all spells.

@export_group("Effects")
##Time in seconds between the cast being called. if this is set to 0, it will only be cast once
@export var cooldown:float
@export var damage:float:
	get:
		return SpellShop.run_through_magic_items(damage, &"affect_outgoing_damage")
##How quickly a projectile travels. May also be used for the length of a shapecast
@export var projectile_speed:float
##How many projectiles are created, per cast
@export var projectile_count:int = 1:
	get:
		return SpellShop.run_through_magic_items(projectile_count, &"affect_projectile_count")
##How many enemies a projectile can pierce through before disappearing. If set to zero this is infinite
@export var projectile_pierce:int = 0:
	get:
		if projectile_pierce > 0:
			return SpellShop.run_through_magic_items(projectile_pierce, &"affect_projectile_pierce")
		else:
			return projectile_pierce
##An option delay between the creation of multiple projectiles in the same casting, in seconds.
@export var multi_projectile_delay:float = 0
##The shape used for this spell. This includes hitboxes for things like earthquake, or projectile hitboxes
@export var shape:Shape2D
@export_group("Appearance")
##The texture that can be used in the spell
@export var texture:Texture2D
##Scale that may be used with a purely visual effect
@export var visual_scale:float = 1


var spell_handler:SpellHandler
var player:Player
var tree:SceneTree

signal finished_casting

func cast() -> void:
	print("A")
	await wait_time(multi_projectile_delay)
	


#region USEFUL SPELL FUNCTIONS
	
func get_random_angle_vector() -> Vector2:
	return Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	
func get_direction_to_nearest_enemy() -> Vector2:
	return player.global_position.direction_to(GameInfo.player.get_closest_enemy_position())

##you need to await this function if you want to await it
func wait_time(time:float) -> void:
	await tree.create_timer(time, false).timeout
	
func get_random_offset(intensity:float = 1.0) -> Vector2:
	return Vector2(GameInfo.rnd.randi_range(-150, 150), GameInfo.rnd.randi_range(-150, 150)) * intensity
	
##This should be a local position
func draw_line_from_player(end_position:Vector2, width = 100, decay:float = 1) -> void:
	draw_line_between_points(player.global_position, end_position, width, decay)
	
##start should be a global position, end should be a local position
func draw_line_between_points(start:Vector2, end:Vector2, width:int = 100, decay:float = 1) -> void:
	var line:VisualEffectLine = VisualEffectLine.new()
	line.add_point(Vector2.ZERO)
	line.add_point(end)
	line.width = width
	line.texture = texture
	line.texture_mode = Line2D.LINE_TEXTURE_TILE
	line.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	GameInfo.projectile_holder.add_child(line)
	line.global_position = start
	line.start_decay_timer(decay)
	

#endregion
