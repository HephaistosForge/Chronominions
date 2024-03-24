extends Control

const ITEM_SELECTION_PREFAB = preload("res://ui_scenes/ingame/item_selection/item_selection.tscn")

var past_item_list
var present_item_list
var future_item_list

var item_lists = [past_item_list, present_item_list, future_item_list]

var future_item_selection
var present_item_selection
var past_item_selection

var epoch_map


func get_item_list_for_epoch(epoch: Globals.Epoch):
	match epoch:
		Globals.Epoch.PAST:
			return past_item_list
		Globals.Epoch.PRESENT:
			return present_item_list
		Globals.Epoch.FUTURE:
			return future_item_list


func get_current_epoch():
	epoch_map.get_current_epoch()
	

func init_item_lists(past, present, future, starting_epoch, epoch_map):
	past_item_list = past
	present_item_list = present
	future_item_list = future
	past_item_selection = generate_item_selection(past_item_list)
	present_item_selection = generate_item_selection(present_item_list)
	future_item_selection = generate_item_selection(future_item_list)
	epoch_map.epoch_changed.connect(_on_epoch_changed)
	set_active_item_list(starting_epoch)


func generate_item_selection(item_list):
	var item_selection = ITEM_SELECTION_PREFAB.instantiate()
	self.add_child(item_selection)
	item_selection.initialize_item_selection(item_list)
	item_selection.visible = false
	return item_selection


func _add_item_to_epoch_list(item_type: Globals.ItemType, epoch: Globals.Epoch):
	match epoch:
		Globals.Epoch.PAST:
			past_item_selection.increase_item_count(item_type, 1)
		Globals.Epoch.PRESENT:
			present_item_selection.increase_item_count(item_type, 1)
		Globals.Epoch.FUTURE:
			future_item_selection.increase_item_count(item_type, 1)

func set_active_item_list(epoch: Globals.Epoch):
	match epoch:
		Globals.Epoch.PAST:
			past_item_selection.visible = true
			present_item_selection.visible = false
			future_item_selection.visible = false
		Globals.Epoch.PRESENT:
			past_item_selection.visible = false
			present_item_selection.visible = true
			future_item_selection.visible = false
		Globals.Epoch.FUTURE:
			past_item_selection.visible = false
			present_item_selection.visible = false
			future_item_selection.visible = true
			

func _on_epoch_changed(epoch: Globals.Epoch):
	set_active_item_list(epoch)
	for i in [past_item_selection, present_item_selection, future_item_selection]:
		i._on_item_selected(self)
