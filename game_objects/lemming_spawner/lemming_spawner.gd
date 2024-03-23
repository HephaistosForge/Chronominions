extends Node2D


const LEMMING_SCENE = preload("res://game_objects/lemmings/lemming.tscn")

var rand = RandomNumberGenerator.new()
var direction = [Globals.NW,Globals.NE,Globals.SW,Globals.SE]


@export var lemming_population: int = 5
@export var init_direction: Globals.Direction

var epoch: Globals.Epoch

func _ready():
	epoch = get_parent().epoch



	
func _on_timer_timeout():
	if lemming_population:
		var lemming_scene = LEMMING_SCENE.instantiate()
		lemming_scene.own_epoch = epoch
		get_parent().add_sibling(lemming_scene)
		lemming_scene.direction = Globals.direction_to_vec(init_direction)#direction[randi_range(0,3)]
		lemming_population-=1
		lemming_scene.global_position = global_position
