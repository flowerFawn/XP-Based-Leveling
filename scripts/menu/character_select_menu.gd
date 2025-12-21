extends Control


@export var node_start_button:Button
@export var node_name_label:Label
@export var node_desc_label:Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("uid://dj5n2ohldosah"))
	GameInfo.character = null

func new_character_selected(character:Character):
	node_name_label.text = character.name
	node_desc_label.text = character.description
	node_start_button.disabled = false

func start_game_proper() -> void:
	get_tree().change_scene_to_packed(preload("uid://dp1bn4tu70hr6"))
