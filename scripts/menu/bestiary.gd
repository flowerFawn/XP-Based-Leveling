extends Control


@export var enemies:Array[EnemyType]
@export var grid_container:GridContainer

func _ready() -> void:
	var new_bestiary_display:BestiaryDisplay
	for enemy in enemies:
		new_bestiary_display = preload("uid://pqjleu8sthqp").instantiate()
		new_bestiary_display.setup(
		enemy.animations.get_frame_texture(&"walk", 0), enemy.enemy_name)
		grid_container.add_child(new_bestiary_display)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(preload("uid://dj5n2ohldosah"))
