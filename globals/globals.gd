extends Node

const NW = Vector2(-1,-0.5)
const NE = Vector2(1,-0.5)
const SW = Vector2(-1,0.5)
const SE = Vector2(1,0.5)

enum Epoch { PAST = 0, PRESENT = 1, FUTURE = 2}


enum Tile { WALK = 0, BOUNCE = 1, DEATH_GRAVITY = 2 }

enum TerrainType {
	DIRT = 0,
	GRASS = 1,
	WATER = 2,
	WET_DIRT = 3,
	ROCKS_FLAT = 4,
	ROCKS_HIGH = 5,
	ROCKS_FLAT_WATER = 6,
	ROCKS_HIGH_WATER = 7,
	ICE = 8,
	DEEP_WATER = 9
}

enum ItemType {
	BOMB,
	FENCE,
	SHOVEL,
	PORTAL_PAST,
	PORTAL_FUTURE,
	PORTAL_PRESENT,
	DIRECTION_NW,
	DIRECTION_NE,
	DIRECTION_SW,
	DIRECTION_SE
}
