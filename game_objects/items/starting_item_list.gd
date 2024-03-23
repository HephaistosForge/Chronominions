class_name StartingItemsList
extends Resource

@export var direction_nw: int
@export var direction_ne: int
@export var direction_sw: int
@export var direction_se: int
@export var bombs: int
@export var shovels: int
@export var fences: int
@export var portal_past: int
@export var portal_present: int
@export var portal_future: int

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(
	_direction_nw = -1, 
	_direction_ne = -1, 
	_direction_sw = -1, 
	_direction_se = -1,
	_bombs = -1,
	_shovels = -1,
	_fences = -1,
	_portal_past = -1,
	_portal_present = -1,
	_portal_future = -1
	):
	direction_nw = _direction_nw
	direction_ne = _direction_ne
	direction_sw = _direction_sw
	direction_se = _direction_se
	bombs = _bombs
	shovels = _shovels
	fences = _fences
	portal_past = _portal_past
	portal_present = _portal_present
	portal_future = _portal_future


func decrease_item_count(item_name: Globals.ItemType):
	match item_name:
		Globals.ItemType.DIRECTION_NW:
			direction_nw -=1
		Globals.ItemType.DIRECTION_NE:
			direction_ne -=1	
		Globals.ItemType.DIRECTION_SW:
			direction_sw -=1
		Globals.ItemType.DIRECTION_SE:
			direction_se -=1
		Globals.ItemType.BOMB:
			bombs -=1
		Globals.ItemType.SHOVEL:
			shovels -=1
		Globals.ItemType.FENCE:
			fences -=1
		Globals.ItemType.PORTAL_PRESENT:
			portal_present -=1
		Globals.ItemType.PORTAL_PAST:
			portal_past -=1
		Globals.ItemType.PORTAL_FUTURE:
			portal_future -=1

func increase_item_count(item_name: Globals.ItemType):
	match item_name:
		Globals.ItemType.DIRECTION_NW:
			direction_nw +=1
		Globals.ItemType.DIRECTION_NE:
			direction_ne +=1	
		Globals.ItemType.DIRECTION_SW:
			direction_sw +=1
		Globals.ItemType.DIRECTION_SE:
			direction_se +=1
		Globals.ItemType.BOMB:
			bombs +=1
		Globals.ItemType.SHOVEL:
			shovels +=1
		Globals.ItemType.FENCE:
			fences +=1
		Globals.ItemType.PORTAL_PRESENT:
			portal_present +=1
		Globals.ItemType.PORTAL_PAST:
			portal_past +=1
		Globals.ItemType.PORTAL_FUTURE:
			portal_future +=1
