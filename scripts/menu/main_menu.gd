extends Control


@export var fade_texture_rect:TextureRect
@export var front_texture_rect:TextureRect
@export var play_button:Button
@export var big_fade_rect:ColorRect

var menu_slides:Dictionary[StringName, Texture2D] = {
	&"Play":preload("uid://cmhl2o814xr2s"),
	&"Settings":preload("uid://ccyaul5gqpvdi"),
	&"Bestiary":preload("uid://dyd6cl6tcj50u"),
	&"Credits":preload("uid://6kq6oxpja73e"),
	&"Quit":preload("uid://8xf80h2lm058")}
	
var visuals_tween:Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fade_tween:Tween = create_tween()
	get_tree().paused = false
	play_button.grab_focus()
	fade_tween.tween_property(big_fade_rect, "color", Color(0, 0, 0, 0), 0.5)


func button_pressed(button_function:StringName) -> void:
	match button_function:
		&"Play":
			get_tree().change_scene_to_packed(preload("uid://caihircp2d6qc"))
		&"Settings":
			get_tree().change_scene_to_packed(load("uid://dgjvvqwas3gcv"))
		&"Bestiary":
			get_tree().change_scene_to_packed(load("uid://bdm4suav3p5q6"))
		&"Credits":
			get_tree().change_scene_to_packed(load("uid://bd7helba444mi"))
		&"Quit":
			get_tree().quit()


func _menu_button_hovered(button_function:StringName) -> void:
	if visuals_tween != null:
		visuals_tween.stop()
	visuals_tween = create_tween()
	front_texture_rect.modulate.a = 0
	fade_texture_rect.modulate.a = 1
	fade_texture_rect.texture = front_texture_rect.texture
	front_texture_rect.texture = menu_slides[button_function]
	visuals_tween.tween_property(fade_texture_rect, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1)
	visuals_tween.parallel().tween_property(front_texture_rect, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1)
