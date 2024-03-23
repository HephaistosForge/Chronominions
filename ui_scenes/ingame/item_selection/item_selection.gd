extends PanelContainer

const ITEM_SELECT_PREFAB: PackedScene = preload("res://ui_scenes/ingame/item_selection/item/item_select.tscn")

@onready var item_select_container = $MarginContainer/HBoxContainer


func initialize_item_selection(starting_items_list: StartingItemsList):
	init_item_selection_items(Bomb.new(), starting_items_list.direction_nw)
	init_item_selection_items(Bomb.new(), starting_items_list.direction_ne)
	init_item_selection_items(Bomb.new(), starting_items_list.direction_sw)
	init_item_selection_items(Bomb.new(), starting_items_list.direction_se)
	init_item_selection_items(Bomb.new(), starting_items_list.bombs)
	init_item_selection_items(Shovel.new(), starting_items_list.shovels)
	init_item_selection_items(Bomb.new(), starting_items_list.fences)
	init_item_selection_items(Bomb.new(), starting_items_list.portal_past)
	init_item_selection_items(Bomb.new(), starting_items_list.portal_present)
	init_item_selection_items(Bomb.new(), starting_items_list.portal_future)

func init_item_selection_items(item, count):
	if count <= 0:
		return
	var item_select = ITEM_SELECT_PREFAB.instantiate()
	item_select_container.add_child(item_select)
	item_select.init_item(item, count)
	item_select.item_selected.connect(_on_item_selected)	
	return item_select
	
func _on_item_selected(node: Node):
	for item in item_select_container.get_children():
		item.on_item_selected(node)

