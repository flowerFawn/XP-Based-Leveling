extends TextureRect
class_name AnimationRect

signal finished

@export var sprites:Array[Texture2D]
@export var fps:int
var current_frame:int = 0

func _ready() -> void:
	texture = sprites[0]
	
func play_animation() -> void:
	while current_frame < len(sprites) - 1:
		await get_tree().create_timer(1.0 / fps).timeout
		current_frame += 1
		texture = sprites[current_frame]
	emit_signal("finished")
