extends CharacterBody2D
var speed:int = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction:Vector2 = Vector2(Input.get_axis("player_left", "player_right"), Input.get_axis("player_up", "player_down"))
	move_and_collide(direction * speed * delta)
