@tool
extends Node2D


@export var direction: Globals.Direction = Globals.Direction.NW:
	set(new_direction):
		self.rotation = deg_to_rad({
			Globals.Direction.NE: 0,
			Globals.Direction.SE: 90,
			Globals.Direction.SW: 180,
			Globals.Direction.NW: 270,
		}[new_direction])
		print(self.rotation)
		direction = new_direction
