extends Spell
class_name SpellSnowstorm

@export var speed_multiplier:float
@export var speed_multiplier_time:float

var gpu_particles:GPUParticles2D
var canvas_layer:CanvasLayer

const particle_process_material:ParticleProcessMaterial = preload("uid://dq455aon8wct8")

func _init() -> void:
	base_description = "Occasionally causes all enemies to be slowed"
	ability_name = "Snowstorm"
	
func initial_spell_setup() -> void:
	gpu_particles = GPUParticles2D.new()
	gpu_particles.process_material = particle_process_material
	gpu_particles.amount = projectile_count
	gpu_particles.lifetime = 5
	gpu_particles.explosiveness = 0.7
	gpu_particles.one_shot = true
	gpu_particles.texture = texture
	#gpu_particles.trail_enabled = true
	gpu_particles.emitting = false
	canvas_layer = CanvasLayer.new()
	GameInfo.world_controller.add_child(canvas_layer)
	canvas_layer.layer = 10
	canvas_layer.add_child(gpu_particles)
	
func clean_up_for_removal() -> void:
	gpu_particles.queue_free()
	canvas_layer.queue_free()
	
	
func cast() -> void:
	for enemy:Enemy in spell_handler.get_tree().get_nodes_in_group(&"Enemy"):
		enemy.change_value_multiplicative(&"active_speed", speed_multiplier, speed_multiplier_time)
		enemy.change_modulate(Color.SKY_BLUE, speed_multiplier_time)
	gpu_particles.restart()
