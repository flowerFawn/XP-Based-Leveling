extends Node
class_name GameController

var time_elapsed:float = 0
##List of polynomials and sine functions for determining enemy weights based on time survived, with the enemy type as the keys
##This helps keep them together in the code
##Unsure if there is another way to do this without having it hardcoded for the lambdas?
var enemy_type_and_weights_dict:Dictionary[EnemyType, Callable] = ({
	preload("uid://bg3osrk3a4ni5"):func (x) -> float: return -0.05 * x * (x - 60) + 1, #0 - goblin type 1
	preload("uid://cr5n22p055thh"):func (x) -> float: return -0.0005 * (x-60) * (x-240), #1 - goblin type 2
	preload("uid://cbke16rl4k8ar"):func (x) -> float: return -0.0005 * (x-60) * (x-240), #2 - goblin type 3
	preload("uid://7mdhf8llrlod"):func (x) -> float: return -0.0005 * (x-60) * (x-240), #3 - goblin type 4
	preload("uid://c6qqqoynid1fh"):func (x) -> float: return sin(x * 0.02) * 1.2, #4 - goblin bomber
	preload("uid://dqunbnln7x2n0"):func (x) -> float: return sin(x * 0.05) * 0.15, #5 - loot goblin
	preload("uid://dc0p6fukw7bp6"):func (x) -> float: return sin(x * 0.01) * 1.2, # 6 martyr
	preload("uid://dihnof1qd7oc1"):func (x) -> float: return -0.0005 * (x-180) * (x-360), #7 - mid goblin 1 
	preload("uid://b5vdf6igrbsnr"):func (x) -> float: return -0.0005 * (x-180) * (x-360), #8 - mid goblin 2
	preload("uid://diyifwsqyg152"):func (x) -> float: return -0.0005 * (x-180) * (x-360), #9 - mid goblin 3
	preload("uid://b5oji5bg8ylg0"):func (x) -> float: return -0.0002 * (x-200) * (x-350), #10 - mid grunt
	preload("uid://d2vrg8gthvpw3"):func (x) -> float: return -0.0003 * (x-200) * (x-350), #11 - mid hammer
	preload("uid://dohokgnvj25ka"):func (x) -> float: return -0.0005 * (x-350) * (x-600), #12 - high goblin 1
	preload("uid://dnhuxtddshtli"):func (x) -> float: return -0.0005 * (x-350) * (x-600), #12 - high goblin 2
	preload("uid://bssmo6phtbsds"):func (x) -> float: return -0.0005 * (x-350) * (x-600), #12 - high goblin 3
	preload("uid://bsmucuhc10knl"):func (x) -> float: return -0.0002 * (x-360) * (x-590), #12 - high grunt
	preload("uid://dt45jm2b3fh5k"):func (x) -> float: return -0.0003 * (x-360) * (x-590), #12 - high hammer
})
##The most recently calculated enemy weights, based on enemy type weight functions array
var enemy_type_current_weight_array:PackedFloat32Array = PackedFloat32Array([])

func update_directions() -> void:
	#updates enemies heading towards the player
	for enemy:Enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.update_direction()
	#updates where aimed spells will go
	if GameInfo.player:
		GameInfo.closest_enemy_to_player_point = GameInfo.player.get_closest_enemy_position()

func do_spawns() -> void:
	spawn_enemies()
	if GameInfo.rnd.randf() <= GameInfo.player_level * 0.01:
		spawn_flower()

func spawn_enemies() -> void:
	var total_enemy_count:int = len(get_tree().get_nodes_in_group(&"Enemy"))
	#0.1x + 50 -(cos^2(0.05x) * 30)
	#most equations are on desmos
	#starts at 10
	var enemy_quota:int = ceili((time_elapsed * 0.1) + 40 - ((cos(0.05 * time_elapsed) ** 2) * 30))
	var enemies_to_spawn:int = ceili((enemy_quota - total_enemy_count) * 0.1)
	update_enemy_weights(time_elapsed)
	for enemy_to_spawn:int in range(enemies_to_spawn):
		spawn_enemy()
		
func spawn_enemy():
	var spawn_position:Vector2
	var new_enemy:Enemy = Enemy.new_enemy(pick_weighted_random_enemy())
	spawn_position = GameInfo.get_global_player_offset_position()
	GameInfo.enemy_holder.add_child(new_enemy)
	new_enemy.global_position = spawn_position

func pick_weighted_random_enemy() -> EnemyType:
	var enemy_type:EnemyType
	enemy_type = enemy_type_and_weights_dict.keys()[GameInfo.rnd.rand_weighted(enemy_type_current_weight_array)]
	return enemy_type
	
func update_enemy_weights(seconds_survived:float) -> void:
	#This should be the index within the enemy type functions array, which should map on
	var new_weights_array:PackedFloat32Array = PackedFloat32Array([])
	var enemy_weight:float
	for enemy:EnemyType in enemy_type_and_weights_dict.keys():
		enemy_weight = enemy_type_and_weights_dict[enemy].call(seconds_survived)
		if enemy_weight > 0:
			new_weights_array.append(enemy_weight)
		else:
			new_weights_array.append(0)
	enemy_type_current_weight_array = new_weights_array
	
func spawn_flower() -> void:
	print("flowey")
	const type_array:Array[StringName] = [&"Heal", &"Magnet"]
	var type_index:int = GameInfo.rnd.rand_weighted(PackedFloat32Array([0.75, 0.25]))
	var type:StringName = type_array[type_index]
	var new_flower:MagicFlower = MagicFlower.create_flower(type)
	GameInfo.projectile_holder.add_child(new_flower)
	new_flower.global_position = GameInfo.get_global_player_offset_position() * GameInfo.rnd.randf()
	
func _process(delta: float) -> void:
	time_elapsed += delta
	GameInfo.game_ui.set_timer(time_elapsed)
	
	
	
	
	
	
	
