extends Node2D

@onready var epoch_map = $EpochMap
@onready var item_selection = $CanvasLayer/PanelContainer4

const ITEM_LIST_RES = preload("res://game_objects/items/starting_item_list.tres")

@export var past_items: StartingItemsList
@export var present_items: StartingItemsList
@export var future_items: StartingItemsList


func _ready():
	item_selection.set_item_list(past_items, present_items, future_items)
