extends Resource
class_name EnemyType

##Properties regarding movement
@export_group("Movement")
##How the enemy moves. This determines direction, not speed
@export var movement_type:EnemyMovementType
##How quickly the enemy moves. This is per second, due to the fact it is multiplied by delta
@export var speed:float

@export_group("Effects")
##The amount of damage done when colliding with the player, and then dying
@export var contact_damage:float


@export_group("Shape")
##The hitbox of the enemy
@export var shape:Shape2D
