extends CharacterBody2D

@onready var world: Node2D
@export var own_epoch: Globals.Epoch

var direction:Vector2 = Globals.NE

func _ready():
	world = get_tree().get_first_node_in_group("world")
	world.epoch_map.epoch_changed.connect(set_visibility)
	


func _physics_process(delta):
	move_and_collide(direction) 
	var curr_epoch_map = world.epoch_map.get_current_epoch_map()
	if not curr_epoch_map.is_on_tile(self):
		self.queue_free()


func set_visibility():
	if own_epoch != world.epoch_map.get_current_epoch():
		self.modulate.a = 0.2
	else:
		self.modulate.a = 1
