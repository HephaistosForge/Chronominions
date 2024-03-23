class_name Bomb extends Item

var bomb_sprite = preload("res://game_objects/items/bomb/SpellBook01_39.png")

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	super._init("Bomb", bomb_sprite, bomb_sprite, Globals.ItemType.BOMB)


func execute_item_action(curr_epoch_map: TileMap) -> bool:
	if not _is_valid_target(curr_epoch_map):
		return false
	return true
	

func _is_valid_target(curr_epoch_map: TileMap) -> bool:
	var position_and_tile_data = curr_epoch_map.get_position_and_tile_data_at_mouse_pos()
	var map_position = position_and_tile_data[0]
	var tile_data = position_and_tile_data[1]
	if tile_data == null:
		return false
	elif tile_data.get_terrain() == Globals.TerrainType.ROCKS_HIGH:
		curr_epoch_map.destroy_rock(map_position)
		return true
	return false

