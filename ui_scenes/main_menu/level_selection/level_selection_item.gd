extends VBoxContainer

@onready var texture = $PanelContainer/TextureRect
@onready var title = $Label
@onready var description = $RichTextLabel
@onready var level_scene

signal signal_button_pressed(lvl_path)

func init(_texture, _title, _description, _level_scene):
	if _texture:
		texture.texture = _texture
	title.text = _title
	description.text = _description
	level_scene = _level_scene


func _on_label_pressed():
	signal_button_pressed.emit(level_scene)
