extends Node

const NW = Vector2(-1,-0.5)
const NE = Vector2(1,-0.5)
const SW = Vector2(-1,0.5)
const SE = Vector2(1,0.5)

enum Direction {NW, NE, SW, SE}
const DirectionToVec = {Direction.NW: NW, Direction.NE: NE, Direction.SW: SW, Direction.SE: SE}

enum Epoch { PAST = -1, PRESENT = 0, FUTURE = 1}

enum Tile { WALK = 0, BOUNCE = 1, DEATH_GRAVITY = 2 }
