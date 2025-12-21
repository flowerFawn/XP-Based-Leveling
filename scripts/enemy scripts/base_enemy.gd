extends Area2D
class_name Enemy
##The enemy type resource that this enemy will be
@export var enemy_type:EnemyType
##Nodes the enemy needs to be able to reference
var node_sprite:Sprite2D
var node_collision:CollisionShape2D
var hit_this_second

##Active versions of stats, so that a single resource can be used for every enemy type but individual enemies still change stats

var active_speed:float

var active_health:float


##so we don't recalculate direction every frame lol
var current_direction:Vector2

var dying:bool = false


func misc_setup() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move(current_direction * active_speed * delta)
	
#region COLLISION
func collision_entered(body:Node2D):
	#If the enemy collides with the player, it does damage and then disappears
	if body.is_in_group(&"Player") and enemy_type.collides_with_player:
		var player:Player = body
		if enemy_type.contact_damage > 0:
			player.take_damage(enemy_type.contact_damage)
			die()
#endregion
#region MOVEMENT
func move(velocity:Vector2) -> void:
	#no move and slide
	position += velocity
	
func update_direction() -> void:
	current_direction = enemy_type.movement_type.get_enemy_direction(global_position, GameInfo.player_position)
	if global_position.x < GameInfo.player_position.x:
		node_sprite.flip_h = true
	else:
		node_sprite.flip_h = false
	
#endregion
#region CONSTRUCTOR
static func new_enemy(enemy_type:EnemyType) -> Enemy:
	var new_enemy_instance:Enemy = Enemy.new()
	if enemy_type.unique_script != null:
		new_enemy_instance.set_script(enemy_type.unique_script)
	new_enemy_instance.add_to_group(&"Enemy")
	new_enemy_instance.set_collision_layer_value(1, false)
	new_enemy_instance.set_collision_layer_value(2, true)
	new_enemy_instance.node_sprite = Sprite2D.new()
	new_enemy_instance.node_sprite.material = ShaderMaterial.new()
	new_enemy_instance.node_sprite.material.shader = preload("uid://6bjklt2wni63")
	#this is so the 200x200 pixel sprites by default take up the 100x100 pixel space we want them to
	new_enemy_instance.node_sprite.scale = Vector2(0.5, 0.5)
	new_enemy_instance.node_collision = CollisionShape2D.new()
	new_enemy_instance.add_child(new_enemy_instance.node_sprite)
	new_enemy_instance.add_child(new_enemy_instance.node_collision)
	new_enemy_instance.enemy_type = enemy_type
	new_enemy_instance.intialise_enemy()
	return new_enemy_instance
	
func intialise_enemy() -> void:
	active_speed = enemy_type.speed
	active_health = enemy_type.base_health
	node_collision.shape = enemy_type.collision
	node_sprite.texture = enemy_type.sprite
	misc_setup()
	if enemy_type.spawn_sound != null:
		play_spawn_sound(enemy_type.spawn_sound)
	if enemy_type.disappear_time > 0:
		disappear_after_time(enemy_type.disappear_time)
	connect("body_entered", collision_entered)
#endregion

func play_spawn_sound(sound:AudioStream):
	var audio_player:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	audio_player.max_distance = 100000
	print("making noise")
	audio_player.stream = sound
	add_child(audio_player)
	await audio_player.tree_entered
	audio_player.play()
	await audio_player.finished
	print("made noise")
	audio_player.queue_free()
	
func disappear_after_time(time:float):
	await tree_entered
	await get_tree().create_timer(time).timeout
	disappear()
	

#region HEALTH
func take_damage(amount:float) -> void:
	active_health -= amount
	if not hit_this_second:
		register_was_hit_this_second()
	visual_damage(amount)
	if active_health <= 0:
		die()
		
func register_was_hit_this_second() -> void:
	hit_this_second = true
	MagicItemInfo.register_enemy_hit_this_second()
	await get_tree().create_timer(1).timeout
	hit_this_second = false


func visual_damage(damage:float) -> void:
	GameInfo.projectile_holder.create_damage_label(global_position, floor(damage))
	#makes the node turn red for a moment
	node_sprite.material.set_shader_parameter(&"harmed", true)
	await get_tree().create_timer(0.3).timeout
	node_sprite.material.set_shader_parameter(&"harmed", false)
	
	
	
func die() -> void:
	if dying:
		return
	dying = true
	SpellShop.spell_xp += enemy_type.xp_reward
	if enemy_type.death_effect != null:
		await enemy_type.death_effect.cause_effect(self)
	queue_free()
	
##Disappearing is different from dying, in that it causes no death effect and no xp reward
func disappear():
	queue_free()
#endregion
