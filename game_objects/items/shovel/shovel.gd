class_name Shovel extends Item

var sprite = preload("res://game_objects/items/shovel/engeniring_28_b.png")
var sprite_transparent = preload("res://game_objects/items/shovel/engeniring_28_t.png")

const VALID_TERRAIN_TYPES = [
	Globals.TerrainType.DEEP_WATER, 
	Globals.TerrainType.WATER, 
	Globals.TerrainType.ICE
	]

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	super._init("Shovel", sprite, sprite_transparent, Globals.ItemType.SHOVEL)


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
	elif tile_data.get_terrain() in VALID_TERRAIN_TYPES:
		curr_epoch_map.remove_water(map_position)
		return true
	return false

