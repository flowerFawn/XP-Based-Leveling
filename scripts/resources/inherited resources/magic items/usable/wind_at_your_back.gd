extends MagicItem
class_name MIWindAtYourBack

##This should be for when gaining this specific level, not culminative
@export var speed_increase:int
##Temporary increase to speed per second while moving
@export var acceleration_per_second:float
##amount to multiply acceleration by and add as a damage multiplier
@export var acceleration_damage_multiplier:float
@export var particle_process_material:ParticleProcessMaterial
var current_acceleration:float

var player_in_question:Player
var gpu_particles:GPUParticles2D
var affect_acceleration_timer:Timer

const texture:Texture2D = preload("uid://d3i02g42je0ld")

func initial_ability_setup() -> void:
	gpu_particles = GPUParticles2D.new()
	gpu_particles.process_material = particle_process_material
	gpu_particles.amount = 100
	gpu_particles.trail_enabled = true
	gpu_particles.texture = texture
	gpu_particles.emitting = false

func clean_up_for_removal() -> void:
	gpu_particles.queue_free()
	affect_acceleration_timer.queue_free()
	

func _init() -> void:
	base_description = "Increases your speed and allows you to accelerate while moving. your damage becomes proportional to your speed"
	ability_name = "Wind At Your Back"
	
func affect_player_stats(player:Player) -> void:
	affect_acceleration_timer = Timer.new()
	player_in_question = player
	player.speed += speed_increase
	player.add_child(affect_acceleration_timer)
	affect_acceleration_timer.timeout.connect(do_acceleration)
	affect_acceleration_timer.start(1)
	player.add_child(gpu_particles)
	
func do_acceleration() -> void:
	update_particles(player_in_question.is_moving)
	if player_in_question.is_moving:
		current_acceleration += acceleration_per_second
		player_in_question.speed += acceleration_per_second
	else:
		player_in_question.speed -= current_acceleration
		current_acceleration = 0

func affect_outgoing_damage(prior_damage:float) -> float:
	return prior_damage * (1 + (current_acceleration * acceleration_damage_multiplier))
	
func update_particles(is_moving:bool) -> void:
	gpu_particles.emitting = is_moving
	gpu_particles.amount_ratio = current_acceleration / 3000
	gpu_particles.lifetime = current_acceleration / 3000

	
	
