extends TileMap

@export var epoch : Globals.Epoch

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = get_local_mouse_position()
		var tile_map_coordinates = local_to_map(mouse_pos)
		if get_cell_tile_data(0, tile_map_coordinates) == null:
			return
		print(tile_map_coordinates)


	
func is_on_tile(node: Node2D) -> bool:
	var local_node_pos = to_local(node.global_position)
	var tile_coord = local_to_map(local_node_pos)
	return get_cell_tile_data(0,tile_coord) != null
		

	
func get_tile_data(node: Node2D) -> bool:
	var local_node_pos = to_local(node.global_position)
	var tile_coord = local_to_map(local_node_pos)
	return get_cell_tile_data(0,tile_coord) != null
