extends Control

@export var credits_container:VBoxContainer
@export var background_color:ColorRect

func _ready() -> void:
	credits_container.position.y = credits_container.size.y
	var credits_tween:Tween = create_tween()
	credits_tween.tween_property(credits_container, "position", Vector2(0, -credits_container.size.y), credits_container.size.y / 50)
	await credits_tween.finished
	return_to_menu()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		return_to_menu()
		
		
func return_to_menu():
	var background_tween:Tween = create_tween()
	credits_container.visible = false
	background_tween.tween_property(background_color, "color", Color.BLACK, 0.5)
	await background_tween.finished
	get_tree().change_scene_to_packed(preload("uid://dj5n2ohldosah"))
