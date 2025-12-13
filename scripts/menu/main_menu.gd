extends Control


@export var fade_texture_rect:TextureRect
@export var front_texture_rect:TextureRect
var menu_slides:Dictionary[StringName, Texture2D] = {
	&"Play":preload("uid://cmhl2o814xr2s"),
	&"Settings":preload("uid://ccyaul5gqpvdi"),
	&"Bestiary":preload("uid://dyd6cl6tcj50u"),
	&"Credits":preload("uid://6kq6oxpja73e"),
	&"Quit":preload("uid://8xf80h2lm058")}
	
var visuals_tween:Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
