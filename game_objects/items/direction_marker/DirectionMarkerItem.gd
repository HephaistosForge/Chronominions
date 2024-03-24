class_name DirectionMarker extends Item

#var sprite = preload("res://game_objects/items/direction_marker/Barbarian_icons_80_t.PNG")
var dir_to_sprite = {
	Globals.Direction.NE: preload("res://game_objects/direction_marker/marker_ne_3.png"),
	Globals.Direction.NW: preload("res://game_objects/direction_marker/marker_nw_3.png"),
	Globals.Direction.SE: preload("res://game_objects/direction_marker/marker_se_3.png"),
	Globals.Direction.SW: preload("res://game_objects/direction_marker/marker_sw_3.png"),
}
var direction: Globals.Direction

const VALID_TERRAIN_TYPES = [
	Globals.TerrainType.DIRT, 
	Globals.TerrainType.GRASS, 
	Globals.TerrainType.WET_DIRT,
	Globals.TerrainType.ROCKS_FLAT,
	Globals.TerrainType.ROCKS_FLAT_WATER
	]

# Called when the node enters the scene tree for the first time.
func _init(_direction) -> void:
	self.direction = _direction
	var item_name_string = "Signpost to " + _direction_to_string(direction)
	var item_type_from_dir = get_item_type_from_direction(direction)
	#super._init(item_name_string, sprite, sprite, item_type_from_dir)
	super._init(item_name_string, dir_to_sprite[_direction], dir_to_sprite[_direction], item_type_from_dir)
	rotation = 90


func get_item_type_from_direction(_direction) -> Globals.ItemType:
	match _direction:
		Globals.Direction.NE:
			return Globals.ItemType.DIRECTION_NE
		Globals.Direction.NW:
			return Globals.ItemType.DIRECTION_NW
		Globals.Direction.SE:
			return Globals.ItemType.DIRECTION_SE
		Globals.Direction.SW:
			return Globals.ItemType.DIRECTION_SW
	return Globals.ItemType.DIRECTION_NE


func _direction_to_string(_direction) -> String:
	match _direction:
		Globals.Direction.NE:
			return "NE"
		Globals.Direction.NW:
			return "NW"
		Globals.Direction.SE:
			return "SE"
		Globals.Direction.SW:
			return "SW"
	return ""


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
		curr_epoch_map.place_marker(map_position, direction)
		return true
	return false

