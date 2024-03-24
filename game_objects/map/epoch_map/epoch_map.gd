extends Node2D

var current_epoch = 0

@onready var available_epochs: Array

signal epoch_changed

func _ready() -> void:
	available_epochs = get_children()
	
	for epoch1 in available_epochs:
		for epoch2 in available_epochs:
			if epoch1 != epoch2:
				assert(epoch1.epoch != epoch2.epoch, "All epoch tile maps must be in different epochs")
	
	# Subscribe to placement events to notify all epoch maps
	for aepoch in available_epochs:
		aepoch.signal_destroy_rock.connect(on_destroy_rock)
		aepoch.signal_remove_water.connect(on_remove_water)
		aepoch.signal_place_fence.connect(on_place_fence)
		aepoch.signal_place_marker.connect(on_place_marker)

# Notify Epoch maps of placement events at certain epochs
func on_destroy_rock(epoch: Globals.Epoch, tile_position: Vector2):
	for child in get_children():
		if child is TileMap:
			child.on_destroy_rock(epoch, tile_position)
func on_remove_water(epoch: Globals.Epoch, tile_position: Vector2):
	for child in get_children():
		if child is TileMap:
			child.on_remove_water(epoch, tile_position)
func on_place_fence(epoch: Globals.Epoch, tile_position: Vector2, fence_scene: PackedScene):
	for child in get_children():
		if child is TileMap:
			child.on_place_fence(epoch, tile_position, fence_scene)
func on_place_marker(epoch: Globals.Epoch, tile_position: Vector2, direction: Globals.Direction):
	for child in get_children():
		if child is TileMap:
			child.on_place_marker(epoch, tile_position, direction)


func fade_out(index: int) -> void:
	var node = available_epochs[index]
	node.propagate_call("set_visible", [false])
	node.visible = false


func fade_in(index: int) -> void:
	var node = available_epochs[index]
	node.propagate_call("set_visible", [true])
	node.visible = true


func blend_to_next() -> void:
	blend_to_new_index(clamp(current_epoch+1, 0, len(available_epochs)-1))


func blend_to_previous() -> void:
	blend_to_new_index(clamp(current_epoch-1, 0, len(available_epochs)-1))


func blend_to_new_index(new_epoch_index):
	if current_epoch != new_epoch_index:
		fade_out(current_epoch)
		current_epoch = clamp(new_epoch_index, 0, len(available_epochs)-1)
		fade_in(current_epoch)
		AudioManager.set_primary_player(available_epochs[current_epoch].epoch)
		epoch_changed.emit(available_epochs[current_epoch].epoch)
		

func get_current_epoch_map() -> TileMap:
	return available_epochs[current_epoch]


func get_epoch_map_from_epoch_enum(epoch: Globals.Epoch):
	for epoch_tile_map in available_epochs:
		if epoch_tile_map.epoch == epoch:
			return epoch_tile_map


func set_current_epoch_from_epoch_enum(epoch: Globals.Epoch):
	for i in range(len(available_epochs)):
		var epoch_tile_map = available_epochs[i]
		if epoch_tile_map.epoch == epoch:
			fade_in(i)
			blend_to_new_index(i)
			return
			
	assert(false, "starting_epoch does not exist in world!")


func get_current_epoch()->int:
	return current_epoch


func get_current_epoch_enum()->Globals.Epoch:
	return available_epochs[current_epoch].epoch
