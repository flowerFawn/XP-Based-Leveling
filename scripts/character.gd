extends CharacterBody2D
class_name Player

@export var node_sprite:Sprite2D
@export var node_progress:ProgressBar
var speed:int = 500
var active_health:float = 100
var max_health:float = 100
##The previous direction of the player. This can have values as zero
var accurate_orientation:Vector2 = Vector2(1, 0)
##The last non-zero direction of the player on the x axis. Should always be 1 or -1
var x_orientation:int = 1
##The last non-zero direction of the player on the y axis. Should always be 1 or -1
var y_orientation:int = 1

##Dictionary that stores the spells and their associated spell handlers. 
##This is a dictionary so that the spellhandlers can be found using their associated spell resource.
var spells:Dictionary[Spell, SpellHandler] = {}

func _ready() -> void:
	GameInfo.player = self
	node_progress.min_value = 0
	node_progress.max_value = max_health
	node_progress.value = active_health

func _physics_process(delta: float) -> void:
	var movement_vector = speed * get_direction()
	move_and_collide(movement_vector * delta)
	GameInfo.update_player_info(self)

	
func get_direction() -> Vector2:
	var direction:Vector2 = Vector2(Input.get_axis("player_left", "player_right"), Input.get_axis("player_up", "player_down")).normalized()
	direction = Vector2(direction.x * abs(Input.get_axis("player_left", "player_right")), direction.y * abs(Input.get_axis("player_up", "player_down")))
	if not direction.is_zero_approx():
		accurate_orientation = direction.snappedf(1)
	if direction.x != 0:
		x_orientation = round(direction.x)
		node_sprite.flip_h = x_orientation > 0
			
	if direction.y != 0:
		y_orientation - round(direction.y)
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
	node_progress.value = active_health
	if active_health <= 0:
		die()
		
func die():
	print("You died! sucks to suck buddy")
	queue_free()
#endregion

#region SPELLS
##Actually creates the spellhandler and starts the casting loop
func start_spell(spell:Spell) -> void:
	var new_spellhandler = SpellHandler.new(spell)
	add_child(new_spellhandler, true)
	spells[spell] = new_spellhandler
	
##Removes a spell and stops it running. mainly used for lower upgrades of spells
func remove_spell(spell:Spell) -> void:
	if not spells.has(spell):
		print("This spell is not there to be removed!")
		return
	spells[spell].free()
	#spells.erase(spell)
	
##Handles starting a spell, and removing a lower upgrade
func add_spell(spell:Spell) -> void:
	if spell.level > 1:
		for old_spell:Spell in spells.keys():
			if old_spell.next_upgrade == spell:
				remove_spell(old_spell)
				break
	start_spell(spell)
	

#endregion
