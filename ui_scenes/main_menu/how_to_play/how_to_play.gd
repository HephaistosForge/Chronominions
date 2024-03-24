extends Control

const TUTORIAL_ITEM_PREFAB = preload("res://ui_scenes/main_menu/how_to_play/how_to_play_item.tscn")

var tutorial_items = [
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/minions.png"), 
		"Minions", 
		"Minions spawn at the entrance gate and move right on the map. Your score is determined by the number of minions leaving through the exit gate."
	],	
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/items.png"), 
		"Items", 
		"Bombs can be placed to destroy mountains, shovels to bridge water."
	],
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/signposts.png"), 
		"Signposts", 
		"Signposts change the direction of crossing minions."
	],
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/pickups.png"), 
		"Pickups", 
		"Minions crossing items on the map will grant them to your inventory."
	],
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/time.png"), 
		"Time", 
		"You can travel through time by clicking the buttons on the left and\
		right arrows. The later levels require you to coordinate your minions\
		across the past, present, and future."
	],
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/portals.png"), 
		"Portals", 
		"Portals can teleport the minions throught time."
	]
	
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in tutorial_items:
		var tut_item = TUTORIAL_ITEM_PREFAB.instantiate()
		$MarginContainer/ScrollContainer/CenterContainer/GridContainer.add_child(tut_item)
		tut_item.init(item[0], item[1], item[2])
		
