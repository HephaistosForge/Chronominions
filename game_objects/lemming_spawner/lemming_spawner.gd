extends Node2D


const LEMMING_SCENE = preload("res://game_objects/lemmings/lemming.tscn")

var rand = RandomNumberGenerator.new()
var direction = [Globals.NW,Globals.NE,Globals.SW,Globals.SE]

signal spawning_finished

@export var lemming_population: int = 5
@export var init_direction: Globals.Direction

var lemmings_to_spawn: int
var epoch: Globals.Epoch

func _ready():
	epoch = get_parent().epoch
	lemmings_to_spawn = lemming_population

func _on_timer_timeout():
	if lemmings_to_spawn > 0:
		var lemming_scene = LEMMING_SCENE.instantiate()
		lemming_scene.own_epoch = epoch
		get_parent().add_sibling(lemming_scene)
		lemming_scene.direction = Globals.direction_to_vec(init_direction)#direction[randi_range(0,3)]
		lemmings_to_spawn-=1
		lemming_scene.global_position = global_position
		lemming_scene.death.connect(get_tree().get_first_node_in_group("world")._on_lemming_death)
	else:
		spawning_finished.emit()
		$Timer.stop()
