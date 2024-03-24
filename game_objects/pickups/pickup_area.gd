# Collision area and logic for a collectible item on the map.
# Use by instantiating the concrete pickup scenes as child of EpochTileMap.
extends Area2D

# The item that is granted to the player when picked up.
@export var item : Item

# The time (and accordingly the map) at which this pickup exists.
var epoch : Globals.Epoch

func _ready():
	# Get epoch from EpochTileMap.
	epoch = get_parent().epoch
	self.body_entered.connect(self._on_body_enter)

func _on_body_enter(body: Node2D):
	if body is Lemming:
		print("lemming detected!", body.own_epoch, epoch)
		if body.own_epoch == epoch:
			self.queue_free()
			var world = get_tree().get_first_node_in_group("world")
			world.add_pickup(item.item_type, epoch)



