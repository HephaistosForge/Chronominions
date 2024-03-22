extends TileMap

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = get_local_mouse_position()
		var tile_map_coordinates = local_to_map(mouse_pos)
		if get_cell_tile_data(0, tile_map_coordinates) == null:
			return
		print(tile_map_coordinates)
