extends Node2D

@export var current_epoch = 0

@onready var available_epochs: Array

signal epoch_changed

func _ready() -> void:
	available_epochs = get_children()


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
	epoch_changed.emit()


func blend_to_previous() -> void:
	fade_out(current_epoch)
	current_epoch -= 1
	current_epoch = clamp(current_epoch, 0, len(available_epochs)-1)
	fade_in(current_epoch)
	epoch_changed.emit()
	
	
func get_current_epoch_map() -> TileMap:
	return available_epochs[current_epoch]
	
	
func get_current_epoch():
	return current_epoch
