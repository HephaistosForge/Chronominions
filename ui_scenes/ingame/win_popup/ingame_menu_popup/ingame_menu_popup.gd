extends PanelContainer

const MAIN_MENU_PREFAB = preload("res://ui_scenes/main_menu/main_menu.tscn")


func _ready():
	get_tree().paused = true


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(MAIN_MENU_PREFAB)


func _on_next_level_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_cancel_pressed() -> void:
	get_tree().paused = false
	self.queue_free()
	

func _exit_tree() -> void:
	get_tree().paused = false
