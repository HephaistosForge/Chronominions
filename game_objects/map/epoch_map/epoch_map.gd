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
	

func fade_out(index: int) -> void:
	var node = available_epochs[index]
	node.propagate_call("set_visible", [false])
	node.visible = false


func fade_in(index: int) -> void:
	var node = available_epochs[index]
	node.propagate_call("set_visible", [true])
	node.visible = true


func blend_to_next() -> void:
	fade_out(current_epoch)
	current_epoch += 1
	current_epoch = clamp(current_epoch, 0, len(available_epochs)-1)
	fade_in(current_epoch)
	AudioManager.set_primary_player(current_epoch)
	epoch_changed.emit(current_epoch)


func blend_to_previous() -> void:
	fade_out(current_epoch)
	current_epoch -= 1
	current_epoch = clamp(current_epoch, 0, len(available_epochs)-1)
	fade_in(current_epoch)
	AudioManager.set_primary_player(current_epoch)
	epoch_changed.emit(current_epoch)
	
	
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
			current_epoch = i
			return
	assert(false,"starting_epoch does not exist in world!")
	
	
func get_current_epoch()->int:
	return current_epoch
	
func get_current_epoch_enum()->Globals.Epoch:
	return available_epochs[current_epoch].epoch
