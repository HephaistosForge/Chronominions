extends Sprite2D


func init_texture(_texture: Texture2D):
	self.texture = _texture

func _process(_delta: float) -> void:
	self.global_position = get_global_mouse_position()
