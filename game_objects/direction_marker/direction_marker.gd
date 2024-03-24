extends Area2D

@onready var direction_to_marker_texture = {
	Globals.Direction.NE: preload("res://game_objects/direction_marker/marker_ne_3.png"),
	Globals.Direction.SE: preload("res://game_objects/direction_marker/marker_se_3.png"),
	Globals.Direction.SW: preload("res://game_objects/direction_marker/marker_sw_3.png"),
	Globals.Direction.NW: preload("res://game_objects/direction_marker/marker_nw_3.png"),
}

@export var direction: Globals.Direction = Globals.Direction.NW:
	set(new_direction):
		direction = new_direction
		for sprite_node in [$Sprite, $Shadow]:
			sprite_node.texture = direction_to_marker_texture[direction]

			
func register_itself_on_epoch_tile_map():
	var parent = get_parent()
	if parent.is_in_group("epoch_tile_map"):
		parent.register_direction_marker(self, Globals.direction_to_vec(direction))
	else:
		assert(false, "DirectionMarker must be child of EpochTileMap!")

func _physics_process(_delta):
	if not Engine.is_editor_hint():
		for body in get_overlapping_bodies():
			if body is Lemming:
				body.direction = Globals.direction_to_vec(direction)
