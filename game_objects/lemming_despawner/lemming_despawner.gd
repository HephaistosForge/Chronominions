extends Area2D

# The time (and accordingly the map) at which this despawner exists.
@export var epoch : Globals.Epoch
# The item that is granted to the player when picked up.
var counter = 0
func _ready():
	self.body_entered.connect(self._on_body_enter)
	
func _on_body_enter(body: Node2D):
	
	if body is Lemming:
		counter+=1
		print("lemming:",counter," detected!")
		if body.own_epoch == epoch:
			body.queue_free()
			
