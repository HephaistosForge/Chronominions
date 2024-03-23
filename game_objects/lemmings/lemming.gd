class_name Lemming extends CharacterBody2D

@onready var world: Node2D
@onready var time_gates: Array
@export var own_epoch: Globals.Epoch

var direction: Vector2 = Globals.NE

func _ready():
	world = get_tree().get_first_node_in_group("world")
	world.epoch_map.epoch_changed.connect(set_visibility)
	
	var animation_name = {
		Globals.NE: "walk_ne",
		Globals.NW: "walk_nw",
		Globals.SW: "walk_sw",
		Globals.SE: "walk_se",
	}[direction]
	$AnimationPlayer.play(animation_name)
	


func _physics_process(delta):
	move_and_collide(direction) 
	var curr_epoch_map = world.epoch_map.get_current_epoch_map()
	if not curr_epoch_map.is_on_tile(self):
		self.die()


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
