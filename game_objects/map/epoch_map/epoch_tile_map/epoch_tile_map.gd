extends TileMap

@export var epoch : Globals.Epoch

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = get_global_mouse_position()
		if get_tile_data_at_mouse_pos() == null:
			return

func world_to_tile_coord(coord: Vector2) -> Vector2:
	return local_to_map(coord)


func get_tile_data_at_mouse_pos() -> TileData:
	var tile_map_coordinates = local_to_map(get_local_mouse_position())
	var tile_data = get_cell_tile_data(0, tile_map_coordinates)
	return tile_data


func get_position_and_tile_data_at_mouse_pos() -> Array:
	var tile_map_coordinates = local_to_map(get_local_mouse_position())
	var tile_data = get_cell_tile_data(0, tile_map_coordinates)
	return [tile_map_coordinates, tile_data]


func get_centered_tile_position_from_world_position(world_pos: Vector2) -> Vector2:
	return to_global(map_to_local(local_to_map(to_local(world_pos))))


func is_on_tile(node: Node2D) -> bool:
	var local_node_pos = to_local(node.global_position)
	var tile_coord = local_to_map(local_node_pos)
	return get_cell_tile_data(0,tile_coord) != null


# HANDLE TILE_MAP_CHANGES
func destroy_rock(tile_position):
	set_cell(0, tile_position, 3, Vector2(6, 5), 0)


func remove_water(tile_position: Vector2):
	set_cell(0, tile_position, 3, Vector2(6, 1), 0)
