extends Node2D


const LEMMING_SCENE = preload("res://game_objects/lemmings/lemming.tscn")

@export var lemming_population: int = 10
@export var init_direction: Vector2 = Globals.NE

	
func _on_timer_timeout():
	if lemming_population:
		var lemming_scene = LEMMING_SCENE.instantiate()
		add_sibling(lemming_scene)
		lemming_scene.global_position = global_position
		lemming_scene.direction = init_direction
		lemming_population-=1
