extends Resource
class_name EnemyType

@export var enemy_name:String
##Properties regarding movement
@export_group("Movement")
##How the enemy moves. This determines direction, not speed
@export var movement_type:EnemyMovementType
##How quickly the enemy moves. This is per second, due to the fact it is multiplied by delta
@export var speed:float

@export_group("Effects")
##The amount of damage done when colliding with the player, and then dying
@export var contact_damage:float

##The base xp awarded upon defeating this enemy
@export var xp_reward:float

##The effect to be called upon death
@export var death_effect:DeathEffect

@export_group("Health")
##How much damage the enemy can take before dying
@export var base_health:float

@export_group("Shape")
##The hitbox of the enemy
@export var collision:Shape2D

@export_group("Appearance")
##The image used for the enemy
@export var animations:SpriteFrames

@export_group("Advanced")
##The script that will replace the base enemy script. Should inherit from Enemy.
##Prefer to use only values, but some mechanics will require a slightly different script (eg. bombers)
@export var unique_script:GDScript
##Sound effect that plays upon spawning. If this is short, prefer wav files.
@export var spawn_sound:AudioStream
##Time until the enemy disappears, after spawning. Disappearing is different from dying
##Disappearing plays a different animation, causes no death effect, and gives no xp reward
##If this is set to 0, this never happens
@export var disappear_time:float = 0
##If the enemy will collide with the player and die. Only should be false for things like loot goblins. Should not deal damage if this is false
@export var collides_with_player:bool = true
