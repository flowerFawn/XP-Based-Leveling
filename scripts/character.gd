extends CharacterBody2D
class_name Player
var speed:int = 500
var active_health:float = 100

var spells:Array[Spell] = []

func _ready() -> void:
	GameInfo.player = self
	add_spell(preload("uid://ciomfgvjduepp"))
	add_spell(preload("uid://dh4308dsgb1xc"))
	add_spell(preload("uid://7vmgb80p33sl"))

func _physics_process(delta: float) -> void:
	var movement_vector = speed * get_direction()
	move_and_collide(movement_vector * delta)
	GameInfo.update_player_info(self)

	
func get_direction() -> Vector2:
	var direction:Vector2 = Vector2(Input.get_axis("player_left", "player_right"), Input.get_axis("player_up", "player_down")).normalized()
	direction = Vector2(direction.x * abs(Input.get_axis("player_left", "player_right")), direction.y * abs(Input.get_axis("player_up", "player_down")))
	return direction
	
func get_closest_enemy() -> Vector2:
	var enemy_point:Vector2
	var lowest_distance_squared:float = 0
	var first_check = true
	for enemy:Enemy in get_tree().get_nodes_in_group(&"Enemy"):
		if first_check:
			enemy_point = enemy.global_position
			lowest_distance_squared = global_position.distance_squared_to(enemy.global_position)
			first_check = false
			continue
		if global_position.distance_squared_to(enemy.global_position) < lowest_distance_squared:
			enemy_point = enemy.global_position
			lowest_distance_squared = global_position.distance_squared_to(enemy.global_position)
	return enemy_point
		

#region HEALTH
func take_damage(amount:float) -> void:
	active_health -= amount
	if active_health <= 0:
		die()
		
func die():
	print("You died! sucks to suck buddy")
	queue_free()
#endregion

#region SPELLS
func add_spell(spell:Spell) -> void:
	spells.append(spell)
	add_child(SpellHandler.new(spell))
		

#endregion
