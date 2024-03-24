@tool
extends Area2D

@export var direction: Globals.Direction = Globals.Direction.NW:
	set(new_direction):
		direction = new_direction
		for sprite_node in [$Sprite, $Shadow]:
			sprite_node.rotation = deg_to_rad({
				Globals.Direction.NE: 0,
				Globals.Direction.SE: 90,
				Globals.Direction.SW: 180,
				Globals.Direction.NW: 270,
			}[new_direction])
			sprite_node.scale = {
				Globals.Direction.NE: Vector2(2, 1),
				Globals.Direction.SE: Vector2(1, 2),
				Globals.Direction.SW: Vector2(2, 1),
				Globals.Direction.NW: Vector2(1, 2),
			}[new_direction]
			
func _ready():
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
