extends TileMap

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = get_local_mouse_position()
		var tile_map_coordinates = local_to_map(mouse_pos)
		if get_cell_tile_data(0, tile_map_coordinates) == null:
			return
		print(tile_map_coordinates)

func world_to_tile_coord(coord: Vector2) -> Vector2:
	return local_to_map(coord)
	
func is_on_tile(node: Node2D) -> bool:
	var local_node_pos = to_local(node.global_position)
	var tile_coord = world_to_tile_coord(local_node_pos)
	return get_cell_tile_data(0,tile_coord) != null
		
