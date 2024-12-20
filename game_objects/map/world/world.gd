extends Node2D

const WIN_POPUP_PREFAB = preload("res://ui_scenes/ingame/win_popup/win_popup.tscn")
const INGAME_MENU_PREFAB = preload("res://ui_scenes/ingame/win_popup/ingame_menu_popup/ingame_menu_popup.tscn")


@onready var button_left = $CanvasLayer/MarginContainer2/TextureButton
@onready var button_right = $CanvasLayer/MarginContainer3/TextureButton2
@onready var past_label = $CanvasLayer/VBoxContainer/MarginContainer/Label
@onready var present_label = $CanvasLayer/VBoxContainer/MarginContainer/Label2
@onready var future_label = $CanvasLayer/VBoxContainer/MarginContainer/Label3




@onready var epoch_map = $EpochMap
@onready var item_selections = $CanvasLayer/ItemSelections
@onready var EPOCH_TO_BACKGROUND_IMAGE = {
	Globals.Epoch.PAST: $Camera2D/BackgroundPast,
	Globals.Epoch.PRESENT: $Camera2D/BackgroundPresent,
	Globals.Epoch.FUTURE: $Camera2D/BackgroundFuture
}
@onready var canvas_layer = $CanvasLayer


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
	Engine.time_scale = 1.0
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
	init_epoch_slider()
		
		
#func _unhandled_input(event):
#	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
#		Engine.time_scale = 5.0
#	else:
#		Engine.time_scale = 1.0


func _on_menu_button_pressed() -> void:
	var popup = INGAME_MENU_PREFAB.instantiate()
	canvas_layer.add_child(popup)


func _on_cheat_button_pressed() -> void:
	for x in 10:
		for y in 3:
			add_pickup(x, y)


func _on_epoch_map_epoch_changed(new_epoch):
	for epoch in EPOCH_TO_BACKGROUND_IMAGE:
		var background = EPOCH_TO_BACKGROUND_IMAGE[epoch]
		background.visible = false
	EPOCH_TO_BACKGROUND_IMAGE[new_epoch].visible = true
	set_available_epoch_swap_buttons(new_epoch)


func init_epoch_slider():
	var available_epochs = epoch_map.get_available_epoch_enums()
	past_label.modulate = Color.WHITE if Globals.Epoch.PAST in available_epochs else Color.DIM_GRAY
	present_label.modulate = Color.WHITE if Globals.Epoch.PRESENT in available_epochs else Color.DIM_GRAY
	future_label.modulate = Color.WHITE if Globals.Epoch.FUTURE in available_epochs else Color.DIM_GRAY

func set_available_epoch_swap_buttons(new_epoch):
	var available_epochs = epoch_map.get_available_epoch_enums()
	button_left.visible = false
	button_right.visible = false
	
	match new_epoch:
		Globals.Epoch.PAST:
			if Globals.Epoch.PRESENT in available_epochs:
				button_right.visible = true
				
		Globals.Epoch.PRESENT:
			if Globals.Epoch.PAST in available_epochs:
				button_left.visible = true
			if Globals.Epoch.FUTURE in available_epochs:
				button_right.visible = true
		Globals.Epoch.FUTURE:
			if Globals.Epoch.PRESENT in available_epochs:
				button_left.visible = true

	


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
		lose()


func win():
	var popup = WIN_POPUP_PREFAB.instantiate()
	popup.configure_popup(true, evacuated_lemmings, max_lemmings)
	canvas_layer.add_child(popup)


func lose():
	var popup = WIN_POPUP_PREFAB.instantiate()
	popup.configure_popup(false, evacuated_lemmings, max_lemmings)
	canvas_layer.add_child(popup)
