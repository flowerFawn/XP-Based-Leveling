extends Node
class_name GameController

var time_elapsed:float = 0

var enemy_type_array:Array[EnemyType] = [
	preload("uid://bg3osrk3a4ni5"), #0 - goblin type 1
	preload("uid://cr5n22p055thh"), #1 - gobin type 2
	preload("uid://cbke16rl4k8ar"), #2 - goblin type 3
	preload("uid://7mdhf8llrlod"), #3 - goblin type 4
	preload("uid://c6qqqoynid1fh"), #4 - goblin bomber
	preload("uid://dqunbnln7x2n0"), #5 - loot goblin
	preload("uid://dc0p6fukw7bp6"), #6 - martyr
]
##List of polynomials and sine functions for determining enemy weights based on time survived
var enemy_type_weight_functions_array:Array[Callable] = ([
	func (x) -> float: return -0.05 * x * (x - 40) + 1,
	func (x) -> float: return -0.0005 * (x-40) * (x-500),
	func (x) -> float: return -0.0005 * (x-40) * (x-500),
	func (x) -> float: return -0.0005 * (x-40) * (x-500),
	func (x) -> float: return sin(x * 0.02) * 1.5,
	func (x) -> float: return sin(x * 0.05) * 0.1,
	func (x) -> float: return sin(x * 0.01) * 1.5
])
##The most recently calculated enemy weights, based on enemy type weight functions array
var enemy_type_current_weight_array:PackedFloat32Array = PackedFloat32Array([])

func update_directions() -> void:
	#updates enemies heading towards the player
	for enemy:Enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.update_direction()
	#updates where aimed spells will go
	if GameInfo.player:
		GameInfo.closest_enemy_to_player_point = GameInfo.player.get_closest_enemy()


func spawn_enemies() -> void:
	var total_enemy_count:int = len(get_tree().get_nodes_in_group(&"Enemy"))
	var enemy_quota:int = (time_elapsed * 0.2) + 8
	var enemies_to_spawn:int = ceili((enemy_quota - total_enemy_count) * 0.1)
	update_enemy_weights(time_elapsed)
	for enemy_to_spawn:int in range(enemies_to_spawn):
		spawn_enemy()
		
func spawn_enemy():
	const CAMERA_DISTANCE_VECTOR:Vector2 = Vector2(2350, 1350)
	var spawn_position:Vector2
	var spawn_offset:Vector2
	var player_position:Vector2 = GameInfo.player_position
	var neg_constant:int = [-1, 1][GameInfo.rnd.randi_range(0, 1)]
	var appears_from_centre:bool = [false, true][GameInfo.rnd.randi_range(0, 1)]
	if appears_from_centre:
		spawn_offset = Vector2(GameInfo.rnd.randi_range(-2300, 2300),neg_constant * CAMERA_DISTANCE_VECTOR.y)
	else:
		spawn_offset = Vector2(neg_constant * CAMERA_DISTANCE_VECTOR.x ,GameInfo.rnd.randi_range(-2300, 2300))
	spawn_position = player_position + spawn_offset
	var new_enemy:Enemy = Enemy.new_enemy(pick_weighted_random_enemy(GameInfo.player_level))
	GameInfo.enemy_holder.add_child(new_enemy)
	new_enemy.global_position = spawn_position

func pick_weighted_random_enemy(level:int) -> EnemyType:
	var enemy_type:EnemyType
	enemy_type = enemy_type_array[GameInfo.rnd.rand_weighted(enemy_type_current_weight_array)]
	return enemy_type
	
func update_enemy_weights(seconds_survived:float) -> void:
	#This should be the index within the enemy type functions array, which should map on
	var new_weights_array:PackedFloat32Array = PackedFloat32Array([])
	var enemy_weight:float
	for i in range(len(enemy_type_weight_functions_array)):
		enemy_weight = enemy_type_weight_functions_array[i].call(seconds_survived)
		if enemy_weight > 0:
			new_weights_array.append(enemy_weight)
		else:
			new_weights_array.append(0)
	enemy_type_current_weight_array = new_weights_array
	
func _process(delta: float) -> void:
	time_elapsed += delta
	GameInfo.game_ui.timer_label.text = "%02d:%02d" % [int(floor(time_elapsed / 60)), int(round(fmod(time_elapsed, 60)))]
	
	
	
	
	
	
	
