class_name Fence extends Item

const FENCE_PREFAB = preload("res://game_objects/items/fence/fence_world_item/fence_world_item.tscn")

var sprite = preload("res://game_objects/items/fence/en_craft_73.png")

const VALID_TERRAIN_TYPES = [
	Globals.TerrainType.DIRT, 
	Globals.TerrainType.GRASS, 
	Globals.TerrainType.WET_DIRT,
	Globals.TerrainType.ROCKS_FLAT,
	Globals.TerrainType.ROCKS_FLAT_WATER
	]

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	super._init("Fence", sprite, sprite, Globals.ItemType.FENCE)


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
	elif curr_epoch_map.get_objects_on_tile(map_position) != null:
		return false
	elif tile_data.get_terrain() in VALID_TERRAIN_TYPES:
		curr_epoch_map.place_fence(map_position, FENCE_PREFAB)
		return true
	return false

