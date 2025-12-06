extends Area2D
class_name Enemy
##The enemy type resource that this enemy will be
@export var enemy_type:EnemyType

##For the constructor
const enemy_scene_preload = preload("uid://kpbomqm3o7r0")

##Active versions of stats, so that a single resource can be used for every enemy type but individual enemies still change stats

var active_speed:float

var active_health:float


var current_direction:Vector2






	
func _physics_process(delta: float) -> void:
	move(current_direction * active_speed * delta)
	
#region COLLISION
func collision_entered(body:Node2D):
	if body.is_in_group(&"Player"):
		var player:Player = body
		player.take_damage(enemy_type.contact_damage)
		#queue_free()
#endregion
#region MOVEMENT
func move(velocity:Vector2) -> void:
	position += velocity
	
func update_direction() -> void:
	current_direction = enemy_type.movement_type.get_enemy_direction(global_position, PlayerInfo.player_position)
	
	
#endregion
#region CONSTRUCTOR
static func new_enemy(enemy_type:EnemyType) -> Enemy:
	var new_enemy_instance:Enemy = enemy_scene_preload.instantiate()
	new_enemy_instance.enemy_type = enemy_type
	new_enemy_instance.intialise_enemy()
	return new_enemy_instance
	
func intialise_enemy() -> void:
	active_speed = enemy_type.speed
	
	
	connect("body_entered", collision_entered)
#endregion
