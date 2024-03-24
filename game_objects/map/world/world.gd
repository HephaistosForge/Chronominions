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

var max_lemmings: int = 0
var evacuated_lemmings: int = 0
var dead_lemmings: int = 0
var spawning_finshed = false


func _ready():
	item_selections.init_item_lists(past_items, present_items, future_items, starting_epoch, epoch_map)
	epoch_map.set_current_epoch_from_epoch_enum(starting_epoch)
	_on_epoch_map_epoch_changed(starting_epoch)
	AudioManager.set_primary_player(starting_epoch)
	AudioManager.sync_players()
	var spawner = get_tree().get_first_node_in_group("spawn")
	max_lemmings = spawner.lemming_population
	spawner.spawning_finished.connect(_on_spawning_finished)
	var finish = get_tree().get_first_node_in_group("finish")
	if finish:
		finish.lemming_despawn.connect(_on_lemming_despawn)
	

func _on_menu_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_epoch_map_epoch_changed(new_epoch):
	for epoch in EPOCH_TO_BACKGROUND_IMAGE:
		var background = EPOCH_TO_BACKGROUND_IMAGE[epoch]
		background.visible = false
	EPOCH_TO_BACKGROUND_IMAGE[new_epoch].visible = true

func add_pickup(type: Globals.ItemType, epoch) -> void:
	item_selections._add_item_to_epoch_list(type, epoch)

func _on_spawning_finished():
	spawning_finshed = true
	check_for_win()
	
func _on_lemming_despawn():
	evacuated_lemmings += 1
	check_for_win()
	
func _on_lemming_death():
	dead_lemmings += 1
	check_for_win()

func check_for_win():
	if not spawning_finshed:
		return
	if len(get_tree().get_nodes_in_group("lemming")) > 1:
		return
	if evacuated_lemmings > 0:
		win()
	else:
		loose()


func win():
	print("WIN")


func loose():
	print("LOOSE")
