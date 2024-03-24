extends PanelContainer



func configure_popup(won: bool, minions_rescued: int, minions_total: int):
	$"MarginContainer/VBoxContainer/HBoxContainer/You won".text = "You won!" if won else "You lost!"
	$MarginContainer/VBoxContainer/HBoxContainer3/Stats.text = "%d / %d minions were successfully rescued!" % [minions_rescued, minions_total]
		


func _on_main_menu_pressed():
	pass # Replace with function body.


func _on_next_level_pressed():
	pass # Replace with function body.
