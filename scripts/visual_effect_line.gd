extends Line2D
class_name VisualEffectLine

func start_decay_timer(time:float = 3) -> void:
	await get_tree().create_timer(time, false).timeout
	queue_free()
