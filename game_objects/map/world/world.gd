extends Node2D

@onready var epoch_map = $EpochMap
@onready var item_selections = $CanvasLayer/ItemSelections

const ITEM_LIST_RES = preload("res://game_objects/items/starting_item_list.tres")

@export var starting_epoch: Globals.Epoch = Globals.Epoch.PRESENT
@export var past_items: StartingItemsList
@export var present_items: StartingItemsList
@export var future_items: StartingItemsList


func _ready():
	item_selections.init_item_lists(past_items, present_items, future_items, starting_epoch, epoch_map)
	epoch_map.set_current_epoch_from_epoch_enum(starting_epoch)
	AudioManager.set_primary_player(starting_epoch)
	AudioManager.sync_players()
	

func _on_menu_button_pressed() -> void:
	get_tree().reload_current_scene()
