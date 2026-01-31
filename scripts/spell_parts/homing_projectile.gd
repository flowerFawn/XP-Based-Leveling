extends PlayerProjectile
class_name HomingPlayerProjectile

var max_force:float
var max_speed:float
var current_velocity:Vector2

func _init(given_max_speed:float, given_max_force:float, damage:float, shape:Shape2D, direction:Vector2, sprite:Texture2D, max_pierce:int = 0, offset:Vector2 = Vector2.ZERO, decay_time:float = 1,new_start_position:Vector2 = Vector2.ZERO) -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	var node_collision = CollisionShape2D.new()
	add_child(node_collision)
	var node_sprite = Sprite2D.new()
	node_sprite.texture = sprite
	add_child(node_sprite)
	node_collision.shape = shape
	active_damage = damage
	max_speed = given_max_speed
	max_force = given_max_force
	current_velocity = given_max_speed * direction
	active_direction = direction.normalized()
	remaining_pierce = max_pierce
	position_offset = offset
	if decay_time > 0:
		start_decay_timer(decay_time)
	#not start position is true when it is equal to Vector2.ZERO (0, 0)
	#this means by default it will begin at the player position
	if not start_position:
		start_position = GameInfo.player_position
	else:
		start_position = new_start_position
	connect("area_entered", hit_something)
	
func _ready() -> void:
	global_position = start_position + position_offset
	
func _physics_process(delta: float) -> void:
	var desired_direction:Vector2
	var steering_force:Vector2
	var closest_enemy_position:Vector2
	var closest_enemy_distance_squared:float = 1000000
	for enemy:Enemy in GameInfo.enemy_handler.get_enemies_near_point(position):
		if position.distance_squared_to(enemy.position) < closest_enemy_distance_squared:
			closest_enemy_position = enemy.position
			closest_enemy_distance_squared = position.distance_squared_to(enemy.position)
	desired_direction = position.direction_to(closest_enemy_position) * max_speed
	steering_force = max_force * (desired_direction - current_velocity)
	current_velocity += steering_force * delta
	current_velocity.limit_length(max_speed)
	move(current_velocity * delta)
	rotation = current_velocity.angle()
	
