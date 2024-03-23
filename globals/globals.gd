extends Node

const NW = Vector2(-1,-0.5)
const NE = Vector2(1,-0.5)
const SW = Vector2(-1,0.5)
const SE = Vector2(1,0.5)

enum Direction {NW, NE, SW, SE}

func direction_to_vec(direction: Direction):
	return {Direction.NW: NW, Direction.NE: NE, Direction.SW: SW, Direction.SE: SE}[direction]

enum Epoch { PAST = -1, PRESENT = 0, FUTURE = 1}

enum Tile { WALK = 0, BOUNCE = 1, DEATH_GRAVITY = 2 }
