class_name Item extends Node2D

var item_selection_texture: Texture2D
var sprite_texture: Texture2D
var item_name: String


func _init(
	_item_name: String,
	_item_selection_texture: Texture2D, 
	_sprite_texture: Texture2D
	):
		self.item_name = _item_name
		self.item_selection_texture = _item_selection_texture
		self.sprite_texture = _sprite_texture


func execute_item_action():
	push_warning("not implemented")
