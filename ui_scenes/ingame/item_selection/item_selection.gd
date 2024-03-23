extends PanelContainer

const ITEM_SELECT_PREFAB: PackedScene = preload("res://ui_scenes/ingame/item_selection/item/item_select.tscn")

@onready var item_select_container = $MarginContainer/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		initialize_item_selection()


func swap_item_selection(index):
	pass


func initialize_item_selection():
	var item_select = ITEM_SELECT_PREFAB.instantiate()
	item_select_container.add_child(item_select)
	item_select.init_item(Bomb.new(), 3)
	item_select.item_selected.connect(_on_item_selected)


func _on_item_selected(node: Node):
	for item in item_select_container.get_children():
		item.on_item_selected(node)
