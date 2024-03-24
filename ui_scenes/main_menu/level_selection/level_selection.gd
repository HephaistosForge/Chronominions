extends Control

const LEVEL_ITEM_PREFAB = preload("res://ui_scenes/main_menu/level_selection/level_selection_item.tscn")

var level_items = []


func _ready() -> void:
	for idx in range(13):
		level_items.append([
			preload("res://icon.svg"),
			"Level " + str(idx),
			"",
			"res://levels/level_" + str(idx) + "/level_" + str(idx) + ".tscn"
		])
	for item in level_items:
		var lvl_item = LEVEL_ITEM_PREFAB.instantiate()
		$MarginContainer/ScrollContainer/CenterContainer/GridContainer.add_child(lvl_item)
		lvl_item.init(item[0], item[1], item[2], item[3])
		lvl_item.signal_button_pressed.connect(load_level)

func load_level(path: String):
	get_tree().change_scene_to_file(path)
