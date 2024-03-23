class_name Lemming extends CharacterBody2D

@onready var world: Node2D
@onready var time_gates: Array
@export var own_epoch: Globals.Epoch

var direction: Vector2 = Globals.NE:
	set(new_direction):
		direction = new_direction
		var animation_name = {
			Globals.NE: "walk_ne",
			Globals.NW: "walk_nw",
			Globals.SW: "walk_sw",
			Globals.SE: "walk_se",
		}[direction]
		$AnimationPlayer.play(animation_name)


func _ready():
	world = get_tree().get_first_node_in_group("world")
	world.epoch_map.epoch_changed.connect(set_visibility)
	var tween = create_tween()
	self.scale = Vector2.ZERO
	tween.tween_property(self, "scale", Vector2(1, 1), 0.4) \
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	set_visibility()



func _physics_process(delta):
	move_and_collide(direction) 
	var lemming_epoch_map = world.epoch_map.get_epoch_map_from_epoch_enum(own_epoch)
	if not lemming_epoch_map.is_on_tile(self):
		self.die()
		return
		
	if lemming_epoch_map.is_on_water(self):
		self.die()
		
	if lemming_epoch_map.is_on_mountain(self):
		self.bounce()
		
	var new_direction = lemming_epoch_map.new_direction_if_on_direction_marker(self)
	if new_direction != null:
		direction = new_direction
		
	
		
		
func bounce():
	direction = -direction

func die():
	# Animation player queue_frees lemming
	$AnimationPlayer.play("die")
	

	

func set_visibility():
	print("Current World Epoch: ",world.epoch_map.get_current_epoch())
	print("Own Epoch: ", own_epoch)
	
	if own_epoch != world.epoch_map.get_current_epoch():
		self.modulate.a = 0.2
	else:
		self.modulate.a = 1
