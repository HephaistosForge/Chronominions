extends Node2D

@onready var epoch_map = $EpochMap
@onready var item_selections = $CanvasLayer/ItemSelections
@onready var EPOCH_TO_BACKGROUND_IMAGE = {
	Globals.Epoch.PAST: $Camera2D/BackgroundPast,
	Globals.Epoch.PRESENT: $Camera2D/BackgroundPresent,
	Globals.Epoch.FUTURE: $Camera2D/BackgroundFuture
}


const ITEM_LIST_RES = preload("res://game_objects/items/starting_item_list.tres")

@export var starting_epoch: Globals.Epoch = Globals.Epoch.PRESENT
@export var past_items: StartingItemsList
@export var present_items: StartingItemsList
@export var future_items: StartingItemsList


func _ready():
	item_selections.init_item_lists(past_items, present_items, future_items, starting_epoch, epoch_map)
	epoch_map.set_current_epoch_from_epoch_enum(starting_epoch)
	_on_epoch_map_epoch_changed(starting_epoch)
	AudioManager.set_primary_player(starting_epoch)
	AudioManager.sync_players()
	

func _on_menu_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_cheat_button_pressed() -> void:
	for x in 9:
		for y in 2:
			add_pickup(x, y)


func _on_epoch_map_epoch_changed(new_epoch):
	for epoch in EPOCH_TO_BACKGROUND_IMAGE:
		var background = EPOCH_TO_BACKGROUND_IMAGE[epoch]
		background.visible = false
	EPOCH_TO_BACKGROUND_IMAGE[new_epoch].visible = true

func add_pickup(type: Globals.ItemType, epoch) -> void:
	item_selections._add_item_to_epoch_list(type, epoch)
