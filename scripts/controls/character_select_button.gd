extends Button
class_name CharacterSelectButton

signal character_option_picked(character:Character)

@export var represents_character:Character

func _ready() -> void:
	var character_appearance_stylebox:StyleBoxTexture = StyleBoxTexture.new()
	character_appearance_stylebox.texture = represents_character.icon
	set(&"theme_override_styles/normal", character_appearance_stylebox)
	set(&"theme_override_styles/hover", character_appearance_stylebox) 
	set(&"theme_override_styles/pressed", character_appearance_stylebox)
	character_option_picked.connect(get_parent_control().get_parent_control().new_character_selected)
	pressed.connect(_pick_this_character)
	
func _pick_this_character() -> void:
	GameInfo.character = represents_character
	emit_signal(&"character_option_picked")
