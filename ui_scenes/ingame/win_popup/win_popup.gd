extends PanelContainer

const MAIN_MENU_PREFAB = preload("res://ui_scenes/main_menu/main_menu.tscn")

func configure_popup(won: bool, minions_rescued: int, minions_total: int):
	$"MarginContainer/VBoxContainer/HBoxContainer/You won".text = "You won!" if won else "You lost!"
	$MarginContainer/VBoxContainer/HBoxContainer3/Stats.text = "%d / %d minions were successfully rescued!" % [minions_rescued, minions_total]



func _on_main_menu_pressed():
	get_tree().change_scene_to_packed(MAIN_MENU_PREFAB)


func _on_next_level_pressed():
	var current_level = get_tree().get_current_scene().get_name()
	var next_level = "level_" + str(int(current_level.lstrip("Level")) + 1)
	next_level = next_level + "/" + next_level + ".tscn"
	var next_level_prefab = load("res://levels/" + next_level)
	get_tree().change_scene_to_packed(next_level_prefab)


func _on_retry_level_pressed():
	get_tree().reload_current_scene()
