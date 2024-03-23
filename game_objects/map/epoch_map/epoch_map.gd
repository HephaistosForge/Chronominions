extends Node2D

@export var current_epoch = 0

@onready var available_epochs: Array


func _ready() -> void:
	available_epochs = get_children()


func fade_out(index: int):
	var node = available_epochs[index]
	node.visible = false


func fade_in(index: int):
	var node = available_epochs[index]
	node.visible = true


func blend_to_next():
	fade_out(current_epoch)
	current_epoch += 1
	current_epoch = clamp(current_epoch, 0, len(available_epochs)-1)
	fade_in(current_epoch)


func blend_to_previous():
	fade_out(current_epoch)
	current_epoch -= 1
	current_epoch = clamp(current_epoch, 0, len(available_epochs)-1)
	fade_in(current_epoch)
	
	
func get_current_epoch_map():
	return available_epochs[current_epoch]
