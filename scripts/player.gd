extends CharacterBody2D
class_name Player

@export var node_sprite:AnimatedSprite2D
@export var node_progress:ProgressBar
@export var node_red_flash_timer:Timer
@export var node_input_buffer_timer:Timer
@export var node_fake_background:TextureRect
var buffer_time

var speed:int = 350
var active_health:float = 100:
	set(value):
		if value >= active_health:
			GameInfo.projectile_holder.create_healing_label(global_position, value - active_health)
		active_health = value
		node_progress.value = value

var max_health:float = 100:
	set(value):
		var change:float = value - max_health
		max_health = value
		active_health += change
		if active_health > max_health:
			active_health = max_health
		node_progress.max_value = value
var flower_multiplier:float = 1

##The previous direction of the player. This can have values as zero
var accurate_orientation:Vector2 = Vector2(1, 0)
##The last non-zero direction of the player on the x axis. Should always be 1 or -1
var x_orientation:int = 1
##The last non-zero direction of the player on the y axis. Should always be 1 or -1
var y_orientation:int = 1
#diagonal input that has been released in the past second. if no diagonal input has been released it will be zero
var released_diagonal_input:Vector2 = Vector2.ZERO
var is_moving:bool = false
var cooldown_multiplier:float = 1:
	set(value):
		#how much to multiply a preexisting cooldown to, to get it to the correct value
		var change_multiplier:float = (1 / cooldown_multiplier) * value
		cooldown_multiplier = clamp(value, 0.01, 1)
		for spell_handler:SpellHandler in get_tree().get_nodes_in_group(&"SpellHandler"):
			update_preexisting_spell_cooldown(spell_handler, change_multiplier)

##Dictionary that stores the spells and their associated spell handlers. 
##This is a dictionary so that the spellhandlers can be found using their associated spell resource.
var spells:Dictionary[Spell, SpellHandler] = {}
var pause_ability_icons:Dictionary[Ability, AbilityIcon]
var magic_items:Array[MagicItem] = []

func _ready() -> void:
	GameInfo.player = self
	buffer_time = Config.input_buffer
	await get_tree().current_scene.ready
	set_character(GameInfo.character)
	node_progress.min_value = 0
	node_progress.max_value = max_health
	node_progress.value = active_health
	node_red_flash_timer.timeout.connect(stop_flash)
	node_input_buffer_timer.timeout.connect(reset_diagonal_input_buffer)
	
func set_character(character:Character) -> void:
	SpellShop.current_ability_pool = character.starting_ability_pool.abilities.duplicate()
	SpellShop.give_ability(character.starting_spell)
	SpellShop.give_ability(character.starting_magic_item)
	node_sprite.sprite_frames = character.animations
	node_sprite.play(&"walk")
	
func _physics_process(delta: float) -> void:
	var movement_vector = speed * get_direction()
	move_and_collide(movement_vector * delta)
	fake_background(movement_vector * delta)
	GameInfo.update_player_info(self)

func fake_background(movement:Vector2) -> void:
	var shader:ShaderMaterial = node_fake_background.material
	var previous_scroll:Vector2 = shader.get_shader_parameter(&"scroll_uv")
	var scroll_change:Vector2 = Vector2(
	movement.x / node_fake_background.size.x, movement.y / node_fake_background.size.y)
	shader.set_shader_parameter(&"scroll_uv", previous_scroll + scroll_change)
	
func get_direction() -> Vector2:
	var direction:Vector2 = Vector2(Input.get_axis("player_left", "player_right"), Input.get_axis("player_up", "player_down")).normalized()
	direction = Vector2(direction.x * abs(Input.get_axis("player_left", "player_right")), direction.y * abs(Input.get_axis("player_up", "player_down")))
	if not direction.is_zero_approx():
		if abs(accurate_orientation.x) == 1 and abs(accurate_orientation.y) == 1 and accurate_orientation != released_diagonal_input and is_moving:
			release_diagonal_input(accurate_orientation)
		accurate_orientation = direction.snappedf(1)
		is_moving = true
		node_sprite.play()
	else:
		if not released_diagonal_input.is_zero_approx() and is_moving:
			accurate_orientation = released_diagonal_input
			node_input_buffer_timer.stop()
			reset_diagonal_input_buffer()
		is_moving = false
		node_sprite.pause()
	if direction.x != 0:
		x_orientation = round(direction.x)
		node_sprite.flip_h = x_orientation < 0
			
	if direction.y != 0:
		y_orientation = round(direction.y)
	return direction
	
func release_diagonal_input(direction:Vector2) -> void:
	if buffer_time == 0:
		return
	released_diagonal_input = direction
	node_input_buffer_timer.start(buffer_time)

func reset_diagonal_input_buffer() -> void:
	released_diagonal_input = Vector2.ZERO
	
func get_closest_enemy_position() -> Vector2:
	var closest_enemy = get_closest_enemy()
	if closest_enemy:
		return get_closest_enemy().global_position
	else:
		return Vector2.ZERO
	
func get_closest_enemy() -> Enemy:
	var closest_enemy:Enemy
	var lowest_distance_squared:float = 0
	var first_check = true
	for enemy:Enemy in get_tree().get_nodes_in_group(&"Enemy"):
		if first_check:
			closest_enemy = enemy
			lowest_distance_squared = global_position.distance_squared_to(enemy.global_position)
			first_check = false
			continue
		if global_position.distance_squared_to(enemy.global_position) < lowest_distance_squared and not enemy.dying:
			closest_enemy = enemy
			lowest_distance_squared = global_position.distance_squared_to(enemy.global_position)
	return closest_enemy
		

#region HEALTH
##Returns if still alive
func take_damage(amount:float) -> bool:
	if amount > 0:
		var affected_damage:float = SpellShop.run_through_magic_items(amount, &"affect_incoming_damage")
		
		active_health -= affected_damage
		if affected_damage > 0:
			visual_damage()
		if active_health <= 0:
			die()
			return false
		return true
	return true
	
func heal(amount:float) -> void:
	if amount <= 0:
		return
	active_health += SpellShop.run_through_magic_items(amount, &"affect_incoming_healing")
	active_health = clamp(active_health, 0, max_health)
		
func visual_damage() -> void:
	const TIME_TO_FLASH:float = 0.2
	node_sprite.material.set_shader_parameter(&"harmed", true)
	node_red_flash_timer.start(TIME_TO_FLASH)
	
func stop_flash() -> void:
	node_sprite.material.set_shader_parameter(&"harmed", false)
	
func die():
	#TODO: replace with a death screen
	stop_flash()
	get_tree().paused = true
	get_tree().call_deferred(&"change_scene_to_packed", load("uid://dj5n2ohldosah"))
	await get_tree().scene_changed
	get_tree().paused = false
#endregion

#region ABILITIES
##Actually creates the spellhandler and starts the casting loop
func start_spell(spell:Spell) -> void:
	var new_spellhandler:SpellHandler = SpellHandler.new(spell)
	spells[spell] = new_spellhandler
	spell.tree = get_tree()
	spell.player = self
	spell.spell_handler = new_spellhandler
	add_child(new_spellhandler)
	spell.initial_ability_setup()
	new_spellhandler.trigger_spell()
	new_spellhandler.start(spell.cooldown * cooldown_multiplier)

	
##Removes a spell and stops it running. mainly used for lower upgrades of spells
func remove_spell(spell:Spell) -> void:
	if not spells.has(spell):
		print("This spell is not there to be removed!")
		return
	await spell.finished_casting
	spell.clean_up_for_removal()
	spells[spell].queue_free()
	spells.erase(spell)
	
##Handles starting a spell, and removing a lower upgrade
func add_ability(ability:Ability) -> void:
	if ability is Spell:
		add_spell(ability)
	elif ability is MagicItem: 
		add_magic_item(ability)
	pause_ability_icons[ability] = GameInfo.pause_menu.add_ability_icon(ability)
	
func add_spell(spell:Spell) -> void:
	if spell.level > 1:
		for old_spell:Spell in spells.keys():
			if old_spell.next_upgrade == spell:
				remove_ability(old_spell)
				break

	start_spell(spell)
	
func add_magic_item(magic_item:MagicItem) -> void:
	if magic_item.level > 1:
		for old_magic_item:MagicItem in magic_items:
			if old_magic_item.next_upgrade == magic_item:
				remove_ability(old_magic_item)
				break
	start_magic_item(magic_item)
				
func remove_magic_item(magic_item:MagicItem) -> void:
	if not magic_item in magic_items:
		print("Magic item not already there!")
		return
	magic_item.clean_up_for_removal()
	magic_items.erase(magic_item)
	
func remove_ability(ability:Ability) -> void:
	pause_ability_icons[ability].queue_free()
	if ability is MagicItem:
		remove_magic_item(ability)
	if ability is Spell:
		remove_spell(ability)
	
func start_magic_item(magic_item:MagicItem) -> void:
	var n:int = 0
	for existing_magic_item in magic_items:
		if existing_magic_item.application_order > magic_item.application_order:
			break
		else:
			n += 1
	magic_items.insert(n ,magic_item)
	magic_item.initial_ability_setup()
	magic_item.affect_player_stats(self)
	
func update_preexisting_spell_cooldown(spell_handler:SpellHandler, change_multiplier:float) -> void:
	spell_handler.start(spell_handler.time_left * change_multiplier) 
	await spell_handler.timeout
	spell_handler.start(spell_handler.spell.cooldown * cooldown_multiplier)
	

#endregion
