extends FunctionalResource
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
##How quickly a projectile travels. May also be used for the length of a shapecast
@export var projectile_speed:float
##How many projectiles are created, per cast
@export var projectile_count:int = 1
##How many enemies a projectile can pierce through before disappearing. If set to zero this is infinite
@export var projectile_pierce:int = 0
##An option delay between the creation of multiple projectiles in the same casting, in seconds.
@export var multi_projectile_delay:float = 0
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
	
func get_random_angle_vector() -> Vector2:
	return Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	
func get_direction_to_nearest_enemy() -> Vector2:
	return GameInfo.player_position.direction_to(GameInfo.closest_enemy_to_player_point)


	
	

#endregion
