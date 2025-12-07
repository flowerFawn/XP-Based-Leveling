extends Area2D
class_name Enemy
##The enemy type resource that this enemy will be
@export var enemy_type:EnemyType
##Nodes the enemy needs to be able to reference
@export var node_sprite:Sprite2D
@export var node_collision:CollisionShape2D

##For the constructor
const enemy_scene_preload = preload("uid://kpbomqm3o7r0")

##Active versions of stats, so that a single resource can be used for every enemy type but individual enemies still change stats

var active_speed:float

var active_health:float


##so we don't recalculate direction every frame lol
var current_direction:Vector2






	
func _physics_process(delta: float) -> void:
	move(current_direction * active_speed * delta)
	
#region COLLISION
func collision_entered(body:Node2D):
	#If the enemy collides with the player, it does damage and then disappears
	if body.is_in_group(&"Player"):
		var player:Player = body
		player.take_damage(enemy_type.contact_damage)
		die()
#endregion
#region MOVEMENT
func move(velocity:Vector2) -> void:
	#no move and slide
	position += velocity
	
func update_direction() -> void:
	current_direction = enemy_type.movement_type.get_enemy_direction(global_position, GameInfo.player_position)
	
	
#endregion
#region CONSTRUCTOR
static func new_enemy(enemy_type:EnemyType) -> Enemy:
	var new_enemy_instance:Enemy = enemy_scene_preload.instantiate()
	new_enemy_instance.enemy_type = enemy_type
	new_enemy_instance.intialise_enemy()
	return new_enemy_instance
	
func intialise_enemy() -> void:
	active_speed = enemy_type.speed
	active_health = enemy_type.base_health
	node_collision.shape = enemy_type.collision
	node_sprite.texture = enemy_type.sprite
	
	
	connect("body_entered", collision_entered)
#endregion

#region HEALTH
func take_damage(amount:float) -> void:
	active_health -= amount
	if active_health <= 0:
		die()
	
func die() -> void:
	queue_free()
	
#endregion
