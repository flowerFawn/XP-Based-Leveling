extends Area2D
class_name PlayerProjectile
##If max pierce is 0, it has unlimited pierce


var active_damage:float
var active_speed:float
var active_direction:Vector2
var remaining_pierce:int
var start_position

func _init(speed:float, damage:float, shape:Shape2D, direction:Vector2, new_start_position:Vector2 = Vector2.ZERO, max_pierce:int = 0) -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	var node_collision = CollisionShape2D.new()
	add_child(node_collision)
	node_collision.shape = shape
	active_damage = damage
	active_speed = speed
	active_direction = direction.normalized()
	remaining_pierce = max_pierce
	#not start position is true when it is equal to Vector2.ZERO (0, 0)
	#this means by default it will begin at the player position
	if not start_position:
		start_position = GameInfo.player_position
	else:
		start_position = new_start_position
	connect("area_entered", hit_something)

func _ready() -> void:
	global_position = start_position

func _physics_process(delta: float) -> void:
	var direction:Vector2 = get_direction()
	move(direction * active_speed)
	
func get_direction() -> Vector2:
	return active_direction
	
##Does not know what delta is, you need to multiply by delta beforehand!
func move(velocity:Vector2):
	position += velocity
	
	
func hit_something(body:Node2D):
	if body.is_in_group(&"Enemy"):
		remaining_pierce -= 1
		#Important that this is = and not <=, so we keep track of pierces done by unlimited pierce but don't kill
		if remaining_pierce == 0:
			queue_free()
		var enemy:Enemy = body
		enemy.take_damage(active_damage)
		print("YAY")
	
