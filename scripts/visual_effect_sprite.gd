extends Sprite2D
class_name VisualEffectSprite

func start_decay_timer(time_to_decay:float) -> void:
	await get_tree().create_timer(time_to_decay, false).timeout
	queue_free()
