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


func get_centered_tile_position_from_world_position(world_pos: Vector2) -> Vector2:
	return to_global(map_to_local(local_to_map(to_local(world_pos))))

func _node_to_tile_data(node: Node2D):
	var local_node_pos = to_local(node.global_position)
	var tile_coord = local_to_map(local_node_pos)
	return get_cell_tile_data(0,tile_coord)

func is_on_tile(node: Node2D) -> bool:
	return _node_to_tile_data(node) != null
	
func _node_to_tile_type(node: Node2D) -> int:
	return _node_to_tile_data(node).get_custom_data("tile_type")
		
func is_on_water(node: Node2D) -> bool:
	return _node_to_tile_type(node) == Globals.Tile.DEATH_GRAVITY

func is_on_mountain(node: Node2D) -> bool:
	return _node_to_tile_type(node) == Globals.Tile.BOUNCE
