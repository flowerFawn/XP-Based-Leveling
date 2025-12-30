extends VBoxContainer
class_name BestiaryDisplay

@export var node_texture:TextureRect
@export var node_label:Label

func setup(texture:Texture2D, name:String):
	node_texture.texture = texture
	node_label.text = name
