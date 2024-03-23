# Collision area and logic for a collectible item on the map.
# Use by instantiating the pickup_area scene in your concrete pickup scene.
extends Area2D

# The time (and accordingly the map) at which this pickup exists.
@export var epoch : Globals.Epoch
# The item that is granted to the player when picked up.
@export var item : Item
# A textureused to show the pickup on the map.
@export var sprite_texture : Texture2D

func _ready():
	self.body_entered.connect(self._on_body_enter)
	$Sprite2D.texture = sprite_texture

func _on_body_enter(body: Node2D):
	if body is Lemming:
		print("lemming detected!")
		if body.own_epoch == epoch:
			self.queue_free()
			
	#		player.add_item(self._item_name)
	push_warning("Pickup action not yet implemented.")
