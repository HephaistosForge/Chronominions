extends TileMap

@export var epoch : Globals.Epoch

var direction_markers: Dictionary = {}

const HIGHLIGHT_MATERIAL = preload("res://visual_effects/highlight_material.tres")

const DIRECTION_MARKER_PREFAB = preload("res://game_objects/direction_marker/direction_marker.tscn")

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	var tile_data = get_tile_data_at_mouse_pos()
	if event is InputEventMouseButton and event.is_pressed():
		if tile_data == null:
			return
	#if event is InputEventMouseMotion:
	#	if tile_data != null:
	#		tile_data.material = HIGHLIGHT_MATERIAL
	#		tile_data.material.set_shader_parameter("width", 1.0)

func world_to_tile_coord(coord: Vector2) -> Vector2:
	return local_to_map(coord)


func register_direction_marker(node: Node2D, direction: Vector2):
	direction_markers[_node_to_tile_coord(node)] = direction


func get_tile_data_at_mouse_pos() -> TileData:
	var tile_map_coordinates = local_to_map(get_local_mouse_position())
	var tile_data = get_cell_tile_data(0, tile_map_coordinates, true)
	return tile_data


func get_position_and_tile_data_at_mouse_pos() -> Array:
	var tile_map_coordinates = local_to_map(get_local_mouse_position())
	var tile_data = get_cell_tile_data(0, tile_map_coordinates)
	return [tile_map_coordinates, tile_data]


func get_centered_tile_position_from_world_position(world_pos: Vector2) -> Vector2:
	return to_global(map_to_local(local_to_map(to_local(world_pos))))


func _node_to_local_coord(node: Node2D):
	return to_local(node.global_position)


func _node_to_tile_coord(node: Node2D):
	return local_to_map(_node_to_local_coord(node))


func _node_to_tile_data(node: Node2D):
	var tile_coord = _node_to_tile_coord(node)
	return get_cell_tile_data(0, tile_coord)


func is_on_tile(node: Node2D) -> bool:
	return _node_to_tile_data(node) != null


func _node_to_tile_type(node: Node2D) -> int:
	return _node_to_tile_data(node).get_custom_data("tile_type")

func is_on_water(node: Node2D) -> bool:
	return _node_to_tile_type(node) == Globals.Tile.DEATH_GRAVITY

func is_on_mountain(node: Node2D) -> bool:
	return _node_to_tile_type(node) == Globals.Tile.BOUNCE

func new_direction_if_on_direction_marker(node: Node2D):
	var tile_coord = _node_to_tile_coord(node)
	if tile_coord in direction_markers:
		if map_to_local(tile_coord).distance_to(_node_to_local_coord(node)) < .1:
			return direction_markers[tile_coord]
	return null

# HANDLE TILE_MAP_CHANGES
func destroy_rock(tile_position):
	set_cell(0, tile_position, 3, Vector2(6, 5), 0)


func remove_water(tile_position: Vector2):
	set_cell(0, tile_position, 3, Vector2(6, 1), 0)
	

func place_marker(tile_position: Vector2, direction: Globals.Direction):
	var marker = DIRECTION_MARKER_PREFAB.instantiate()
	self.add_child(marker)
	marker.direction = direction
	marker.global_position = to_global(map_to_local(tile_position))

func place_portal(tile_position: Vector2, portal_epoch: Globals.Epoch, portal_scene: PackedScene):
	var portal = portal_scene.instantiate()
	self.add_child(portal)
	portal.get_child(0).portal_direction = portal_epoch
	portal.get_child(0).epoch = self.epoch
	portal.global_position = to_global(map_to_local(tile_position))
