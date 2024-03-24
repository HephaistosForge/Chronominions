extends PanelContainer

const TUTORIAL_ITEM_PREFAB = preload("res://ui_scenes/main_menu/how_to_play/how_to_play_item.tscn")

@onready var tutorial_container = $MarginContainer/VBoxContainer/VBoxContainer

var tutorial_items = [
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/minions.png"), 
		"Minions", 
		"Minions spawn at the entrance gate and move right on the map. Your score is determined by the number of minions leaving through the exit gate. Minions can fall of the map or drown in water."
	],	
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/items.png"), 
		"Items", 
		"Bombs can be placed to destroy mountains, shovels to bridge water. You only have limited amounts of items."
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
		"You can travel through time by clicking the buttons on the left and right arrows. The later levels require you to coordinate your minions across the past, present, and future."
	],
	[
		preload("res://ui_scenes/main_menu/how_to_play/screenshots/portals.png"), 
		"Portals", 
		"Portals can teleport the minions through time."
	]
	
]

@export var variant: int = 0

var tut_item_ref

func _ready():
	instantiate_tut_item()
	
	get_tree().paused = true

func instantiate_tut_item():
	var tut_item = TUTORIAL_ITEM_PREFAB.instantiate()
	var item = tutorial_items[variant]
	tutorial_container.add_child(tut_item)
	tut_item.init(item[0], item[1], item[2])
	tut_item_ref = tut_item

func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_pressed() -> void:
	if variant == 4:
		tut_item_ref.queue_free()
		variant = 5
		instantiate_tut_item()
	else:
		get_tree().paused = false
		self.queue_free()
