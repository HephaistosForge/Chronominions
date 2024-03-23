class_name Bomb extends Item

var bomb_sprite = preload("res://game_objects/items/bomb/SpellBook01_39.png")

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	super._init("Bomb", bomb_sprite, bomb_sprite)


func execute_item_action(curr_epoch_map: TileMap) -> bool:
	if not _is_valid_target(curr_epoch_map):
		return false
	return true
	

func _is_valid_target(curr_epoch_map: TileMap) -> bool:
	return curr_epoch_map.get_tile_data_at_mouse_pos() != null

