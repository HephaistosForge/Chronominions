extends Sprite2D

@onready var positions : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	positions.append(Vector2(18, 53))
	positions.append(Vector2(256, 53))
	positions.append(Vector2(486, 53))
	_on_epoch_map_epoch_changed(get_tree().get_first_node_in_group("world").starting_epoch)


func _on_epoch_map_epoch_changed(epoch: Globals.Epoch):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", positions[epoch], 0.3)
