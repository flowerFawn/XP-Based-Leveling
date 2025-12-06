extends CharacterBody2D
class_name Player
var speed:int = 500
var active_health:float = 100

var spells:Array[Spell] = []
var casting_spells:bool = true

func _ready() -> void:
	add_spell(preload("uid://dh4308dsgb1xc"))

func _physics_process(delta: float) -> void:
	var movement_vector = speed * get_direction()
	move_and_collide(movement_vector * delta)
	PlayerInfo.update_info(self)

	
func get_direction() -> Vector2:
	var direction:Vector2 = Vector2(Input.get_axis("player_left", "player_right"), Input.get_axis("player_up", "player_down")).normalized()
	direction = Vector2(direction.x * abs(Input.get_axis("player_left", "player_right")), direction.y * abs(Input.get_axis("player_up", "player_down")))
	return direction

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
	spell.cast(self)
	spells.append(spell)
	if spell.cooldown != 0:
		loop_spell(spell)
		
func loop_spell(spell:Spell) -> void:
	var spell_timer: Timer = Timer.new()
	add_child(spell_timer)
	while casting_spells:
		spell_timer.start(spell.cooldown)
		await spell_timer.timeout
		spell.cast(self)
#endregion
