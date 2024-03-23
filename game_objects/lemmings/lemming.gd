extends CharacterBody2D

@onready var world: Node2D


var direction:Vector2 = Globals.NE

func _ready():
	world = get_tree().get_first_node_in_group("world")
	

func _physics_process(delta):
	move_and_collide(direction) 
	var curr_epoch_map = world.epoch_map.get_current_epoch_map()
	if not curr_epoch_map.is_on_tile(self):
		self.queue_free()
