class_name Bomb extends Item

var bomb_sprite = preload("res://icon.svg")

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	super._init("Bomb", bomb_sprite, bomb_sprite)


func execute_item_action() -> bool:
	return true
	

func _is_valid_target() -> bool:
	return true
