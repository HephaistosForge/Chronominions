extends Node2D


const LEMMING_SCENE = preload("res://game_objects/lemmings/lemming.tscn")

var rand = RandomNumberGenerator.new()
var direction = [Globals.NW,Globals.NE,Globals.SW,Globals.SE]


@export var lemming_population: int = 10
@export var init_direction: Vector2 = Globals.NE
@export var init_epoch: Globals.Epoch = Globals.Epoch.PAST





	
func _on_timer_timeout():
	if lemming_population:
		var lemming_scene = LEMMING_SCENE.instantiate()
		lemming_scene.direction = direction[randi_range(0,3)]
		lemming_scene.own_epoch = rand.randi_range(-1,1)
		lemming_population-=1
		add_sibling(lemming_scene)
		lemming_scene.global_position = global_position
