extends PanelContainer

const ITEM_SELECT_PREFAB: PackedScene = preload("res://ui_scenes/ingame/item_selection/item/item_select.tscn")

@onready var item_select_container = $MarginContainer/HBoxContainer

var item_selection_refs: Dictionary


func initialize_item_selection(starting_items_list: StartingItemsList):
	item_selection_refs[Globals.ItemType.DIRECTION_NW] = init_item_selection_items(DirectionMarker.new(Globals.Direction.NW), starting_items_list.direction_nw)
	item_selection_refs[Globals.ItemType.DIRECTION_NE] = init_item_selection_items(DirectionMarker.new(Globals.Direction.NE), starting_items_list.direction_ne)
	item_selection_refs[Globals.ItemType.DIRECTION_SW] = init_item_selection_items(DirectionMarker.new(Globals.Direction.SW), starting_items_list.direction_sw)
	item_selection_refs[Globals.ItemType.DIRECTION_SE] = init_item_selection_items(DirectionMarker.new(Globals.Direction.SE), starting_items_list.direction_se)
	item_selection_refs[Globals.ItemType.BOMB] = init_item_selection_items(Bomb.new(), starting_items_list.bombs)
	item_selection_refs[Globals.ItemType.SHOVEL] = init_item_selection_items(Shovel.new(), starting_items_list.shovels)
	item_selection_refs[Globals.ItemType.FENCE] = init_item_selection_items(Fence.new(), starting_items_list.fences)
	item_selection_refs[Globals.ItemType.PORTAL_PAST] = init_item_selection_items(TimePortalItem.new(Globals.Epoch.PAST), starting_items_list.portal_past)
	item_selection_refs[Globals.ItemType.PORTAL_PRESENT] = init_item_selection_items(TimePortalItem.new(Globals.Epoch.PRESENT), starting_items_list.portal_present)
	item_selection_refs[Globals.ItemType.PORTAL_FUTURE] = init_item_selection_items(TimePortalItem.new(Globals.Epoch.FUTURE), starting_items_list.portal_future)


func init_item_selection_items(item, count):
	var item_select = ITEM_SELECT_PREFAB.instantiate()
	item_select_container.add_child(item_select)
	item_select.init_item(item, count)
	item_select.item_selected.connect(_on_item_selected)	
	return item_select


func increase_item_count(item_type, value):
	item_selection_refs[item_type].set_count(item_selection_refs[item_type].count + value)


func _on_item_selected(node: Node):
	for item in item_select_container.get_children():
		item.on_item_selected(node)

