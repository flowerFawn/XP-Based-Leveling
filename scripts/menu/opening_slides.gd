extends Control
@export var slides:Array[Texture2D]
@export var last_slide_rect:TextureRect
@export var next_slide_rect:TextureRect

func _ready() -> void:
	const SLIDE_DISPLAY_TIME:float = 2.0
	const SLIDE_TRANSITION_TIME:float = 0.5
	const VISIBLE:Color = Color(1.0, 1.0, 1.0, 1.0)
	const INVISIBLE:Color = Color(1.0, 1.0, 1.0, 0.0)
	if Config.skip_intro:
		load_main_menu()
	var transition_tween:Tween
	for n in range(len(slides)):
		next_slide_rect.texture = slides[n]
		if n > 0:
			last_slide_rect.texture = slides[n - 1]
		last_slide_rect.modulate = VISIBLE
		next_slide_rect.modulate = INVISIBLE
		transition_tween = create_tween()
		transition_tween.set_parallel(true)
		transition_tween.tween_property(next_slide_rect, "modulate", VISIBLE, SLIDE_TRANSITION_TIME)
		transition_tween.tween_property(last_slide_rect, "modulate", INVISIBLE, SLIDE_TRANSITION_TIME)
		await transition_tween.finished
		await get_tree().create_timer(SLIDE_DISPLAY_TIME).timeout
	transition_tween = create_tween()
	transition_tween.tween_property(next_slide_rect, "modulate", INVISIBLE, SLIDE_TRANSITION_TIME)
	await transition_tween.finished
	load_main_menu()
	
func load_main_menu() -> void:
	get_tree().change_scene_to_packed(preload("uid://dj5n2ohldosah"))
