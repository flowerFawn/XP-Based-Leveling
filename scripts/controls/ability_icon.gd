extends TextureRect
class_name AbilityIcon

@export var level_label:Label

const PRELOADED_SCENE:PackedScene = preload("uid://ny3g87jvu4ac")
static var level_to_numeral:Array[String] = ["N", "I", "II", "III", "IV", "V", "VI", "VII", "VIII"]

static func new_ability_icon(icon:Texture2D, level:int) -> AbilityIcon:
	var new_ability_icon:AbilityIcon = PRELOADED_SCENE.instantiate()
	new_ability_icon.texture = icon
	if level <= 8:
		new_ability_icon.level_label.text = level_to_numeral[level]
	return new_ability_icon
	
