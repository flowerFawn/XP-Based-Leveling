extends Ability
class_name Spell
##The resource used for spells that are repeatedly cast as attacks. Contains the functions to cast the spell.
##These variables tend to be used differently by different spells, and not all fields will be used by all spells.


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



func cast(player:Player, spell_handler:SpellHandler) -> void:
	print("A")


#region USEFUL SPELL FUNCTIONS
	
func get_random_angle_vector() -> Vector2:
	return Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	
func get_direction_to_nearest_enemy() -> Vector2:
	return GameInfo.player_position.direction_to(GameInfo.closest_enemy_to_player_point)


	
	

#endregion
