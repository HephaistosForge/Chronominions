class_name TimePortalItem extends Item

const PORTAL_PAST_PREFAB = preload("res://game_objects/time_gate/time_gate_past.tscn")
const PORTAL_PRESENT_PREFAB = preload("res://game_objects/time_gate/time_gate_present.tscn")
const PORTAL_FUTURE_PREFAB = preload("res://game_objects/time_gate/time_gate_future.tscn")

var sprite = preload("res://game_objects/items/portal/time_portal/b_04.png")

var epoch

const VALID_TERRAIN_TYPES = [
	Globals.TerrainType.DIRT, 
	Globals.TerrainType.GRASS, 
	Globals.TerrainType.WET_DIRT,
	Globals.TerrainType.ROCKS_FLAT,
	Globals.TerrainType.ROCKS_FLAT_WATER
	]

# Called when the node enters the scene tree for the first time.
func _init(_epoch: Globals.Epoch) -> void:
	self.epoch = _epoch
	var item_name_string = "Portal to the " + _epoch_to_string(_epoch)
	var item_type_from_epoch = get_item_type_from_epoch(_epoch)
	super._init(item_name_string, sprite, sprite, item_type_from_epoch)


func get_item_type_from_epoch(_epoch) -> Globals.ItemType:
	match _epoch:
		Globals.Epoch.PAST:
			return Globals.ItemType.PORTAL_PAST
		Globals.Epoch.PRESENT:
			return Globals.ItemType.PORTAL_PRESENT
		Globals.Epoch.FUTURE:
			return Globals.ItemType.PORTAL_FUTURE
	return Globals.ItemType.PORTAL_FUTURE


func _epoch_to_string(_epoch) -> String:
	match _epoch:
		Globals.Epoch.PAST:
			return "Past"
		Globals.Epoch.PRESENT:
			return "Present"
		Globals.Epoch.FUTURE:
			return "Future"
	return ""
	
func get_prefab_for_epoch(_epoch):
	match _epoch:
		Globals.Epoch.PAST:
			return PORTAL_PAST_PREFAB
		Globals.Epoch.PRESENT:
			return PORTAL_PRESENT_PREFAB
		Globals.Epoch.FUTURE:
			return PORTAL_FUTURE_PREFAB

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
		curr_epoch_map.place_portal(map_position, epoch, get_prefab_for_epoch(epoch))
		return true
	return false

