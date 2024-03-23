extends Node2D

@onready var epoch_map = $EpochMap
@onready var item_selections = $CanvasLayer/ItemSelections

const ITEM_LIST_RES = preload("res://game_objects/items/starting_item_list.tres")

@export var starting_epoch: Globals.Epoch = Globals.Epoch.PRESENT
@export var past_items: StartingItemsList
@export var present_items: StartingItemsList
@export var future_items: StartingItemsList


func _ready():
	item_selections.init_item_lists(past_items, present_items, future_items, starting_epoch, epoch_map)
	
