extends PanelContainer

const CURSOR_ITEM_PREVIEW_PREFAB = preload("res://game_objects/items/cursor_item_preview/cursor_item_preview.tscn")

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var count_label: Label = $MarginContainer2/Label
@onready var item_name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/ItemNameLabel

var item: Item 
var count: int
var selected = false
var cursor_item_preview = null

signal item_selected


func init_item(_item: Item, _count: int) -> void:
	self.item = _item
	self.count = _count
	set_item_texture(item.item_selection_texture)
	set_item_title(item.item_name)
	set_count_label(_count)


func set_item_title(title: String) -> void:
	item_name_label.text = title


func set_count_label(_count: int) -> void:
	count_label.text = str(_count)


func set_item_texture(texture: Texture2D) -> void:
	texture_rect.texture = texture


func select_item() -> void:
	selected = true
	modulate = Color.GREEN
	item_selected.emit(self)
	cursor_item_preview = CURSOR_ITEM_PREVIEW_PREFAB.instantiate()
	cursor_item_preview.init_texture(item.sprite_texture)
	get_tree().get_root().add_child(cursor_item_preview)


func deselect_item() -> void:
	selected = false
	modulate = Color.WHITE
	if cursor_item_preview:
		cursor_item_preview.queue_free()


func _process(_delta: float) -> void:
	if not selected:
		return
	if Input.is_action_pressed("deselect"):
		deselect_item()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and count > 0:
		if event.button_index == 1 and not selected:
			selected = true
			select_item()
			

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == 1 and selected:
			var curr_epoch_map = get_tree().get_first_node_in_group("world").epoch_map.get_current_epoch_map()
			if item.execute_item_action(curr_epoch_map):
				self.count -= 1
				set_count_label(self.count)
				deselect_item()
				if count <= 0:
					modulate = Color.DARK_GRAY


func on_item_selected(node: Node):
	if node != self and selected:
		deselect_item()
