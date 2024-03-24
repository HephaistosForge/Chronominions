extends TextureButton


@export var speed_up: float = 1.0

func _ready():
	self.pressed.connect(_on_button_pressed)


func _on_button_pressed():
	Engine.time_scale = speed_up
