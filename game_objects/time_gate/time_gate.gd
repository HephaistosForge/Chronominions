class_name TimeGate extends Area2D

@export var portal_direction: Globals.PortalDirection
@export var epoch: Globals.Epoch


func _ready():
	self.body_entered.connect(self._on_body_enter)
	
func _on_body_enter(body: Node2D):
	if body is Lemming:
		print("TimeGate detected a lemming")
		print(body.own_epoch)
		if body.own_epoch == epoch:
			change_epoch(body)
			print(body.own_epoch)
			
func change_epoch(body: Node2D):
	body.own_epoch = portal_direction
	body.set_visibility()
