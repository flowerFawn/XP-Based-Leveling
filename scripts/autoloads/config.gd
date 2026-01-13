extends Node

const CONFIG_FILE_NAME:String = "user://config.tres"
var current_config:ConfigOptions

var skip_intro:bool:
	get:
		return current_config.skip_intro
	set(value):
		current_config.skip_intro = value
var input_buffer:float:
	get:
		return current_config.input_buffer
	set(value):
		current_config.input_buffer = value
var screen_mode:int:
	get:
		return current_config.screen_mode
	set(value):
		current_config.screen_mode = value
		
		

func serialise() -> void:
	print(ResourceSaver.save(current_config, CONFIG_FILE_NAME))
	print(current_config)
	
func update_based_on_config() -> void:
	DisplayServer.window_set_mode(screen_mode)

func _ready() -> void:
	if not FileAccess.file_exists(CONFIG_FILE_NAME):
		current_config = ConfigOptions.new()
		ResourceSaver.save(current_config, CONFIG_FILE_NAME)
	elif ResourceLoader.exists(CONFIG_FILE_NAME):
		current_config = ResourceLoader.load(CONFIG_FILE_NAME, "ConfigOptions")
	update_based_on_config()
