extends Resource
class_name Spell
##The resource used for spells that are repeatedly cast as attacks. Contains the functions to cast the spell.
##These variables tend to be used differently by different spells, and not all fields will be used by all spells.
@export_group("Technical")
##The level of this spell, starting at 1. Important for removing the previous level of spell, and menus
@export_range(1, 20) var level:int  = 1
##The second half of the description in menus, unique to each level. this is added to the end of the description
##The part before this is the base description, set in the class itself
@export var level_description:String
##The Image used in 
@export var icon:Texture2D
##The spell that will be added to the spell pool when this spell is chosen. If left null there are no more upgrades to this spell
@export var next_upgrade:Spell
@export_group("Effects")
##Time in seconds between the cast being called. if this is set to 0, it will only be cast once
@export var cooldown:float
@export var damage:float
@export var projectile_speed:float
##The shape used for this spell. This includes hitboxes for things like earthquake, or projectile hitboxes
@export var shape:Shape2D
@export_group("Appearance")
##The texture that can be used in the spell
@export var texture:Texture2D
##Scale that may be used with a purely visual effect
@export var visual_scale:float = 1

#these values should be updated in the _init() of each inherited spell class
##Description of the spell itself, shown in menus
var base_description:String = "Base spell class that others inherit from. 
Contains many useful subroutines. If you're seeing this, the description of a spell wasn't set properly"
##Name of the spell in text, shown in menus
var spell_id:String = "Test Spell (why can you see this?)"

func cast(player:Player, spell_handler:SpellHandler) -> void:
	print("A")


#region USEFUL SPELL FUNCTIONS
func get_shapecast_colliders(shapecast:ShapeCast2D) -> Array[Node2D]:
	var collider_array:Array[Node2D] = []
	for n in range(0, shapecast.get_collision_count()):
		collider_array.append(shapecast.get_collider(n))
	return collider_array
	
func create_shapecast(shape:Shape2D) -> ShapeCast2D:
	var shapecast = ShapeCast2D.new()
	shapecast.shape = shape
	shapecast.set_collision_mask_value(2, true)
	shapecast.collide_with_areas = true
	shapecast.collide_with_bodies = false
	shapecast.target_position = Vector2.ZERO
	return shapecast
	
func get_random_angle_vector() -> Vector2:
	return Vector2.RIGHT.rotated(randi_range(0, 2 * PI))
	
func get_direction_to_nearest_enemy() -> Vector2:
	return GameInfo.player_position.direction_to(GameInfo.closest_enemy_to_player_point)

func create_visual_effect(sprite:Texture2D, global_position:Vector2, scale:float = 1, decay_time:float = 3) -> void:
	var effect_sprite:VisualEffectSprite = VisualEffectSprite.new()
	effect_sprite.texture = sprite
	effect_sprite.scale = Vector2(scale, scale)
	GameInfo.projectile_holder.add_child(effect_sprite)
	effect_sprite.global_position = global_position
	effect_sprite.start_decay_timer(decay_time)
	
	

#endregion
