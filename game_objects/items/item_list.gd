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
	_direction_nw = 0, 
	_direction_ne = 0, 
	_direction_sw = 0, 
	_direction_se = 0,
	_bombs = 0,
	_shovels = 0,
	_fences = 0,
	_portal_past = 0,
	_portal_present = 0,
	_portal_future = 0
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
