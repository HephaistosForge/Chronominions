extends Node

const NW = Vector2(-1,-0.5)
const NE = Vector2(1,-0.5)
const SW = Vector2(-1,0.5)
const SE = Vector2(1,0.5)

enum Epoch { PAST = 0, PRESENT = 1, FUTURE = 2}


enum PortalDirection {PAST = 0, PRESENT = 1, FUTURE = 2}


enum Tile { WALK = 0, BOUNCE = 1, DEATH_GRAVITY = 2 }
