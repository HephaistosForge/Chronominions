extends TextureButton


@export var epoch: Globals.Epoch

func _ready():
	self.pressed.connect(_on_button_pressed)


func _on_button_pressed():
	get_parent().get_parent().get_node("EpochMap").set_current_epoch_from_epoch_enum(epoch)
