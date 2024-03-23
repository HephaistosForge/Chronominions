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
	self.area_entered.connect(self._on_obj_enter)
	$Sprite2D.texture = sprite_texture

func _on_obj_enter(obj: Area2D):
	# parent = obj.get_parent()
	#if is_instance_of(parent, Lemming):
	#	if parent.epoch == epoch:
	#		player.add_item(self._item_name)
	push_warning("Pickup action not yet implemented.")
