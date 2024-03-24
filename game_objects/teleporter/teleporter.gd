class_name Teleporter extends Area2D

signal ported
@export var partner: Teleporter 
@export var cooldown: Array
var tele_epoch: Globals.Epoch
# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(self._on_body_enter)
	partner.ported.connect(handle_cooldown_for_body)
	tele_epoch = get_parent().epoch

func _on_body_enter(body: Node2D):
	if body.own_epoch == tele_epoch:
		if body is Lemming:
			print("Teleporter detected a lemming")
			print("Partner is ",partner.global_position)
			if body not in cooldown:
				ported.emit(body)
				handle_cooldown_for_body(body)
				body.global_position = partner.global_position
		
		

	
func handle_cooldown_for_body(body: Node2D):
	cooldown.append(body)
	await get_tree().create_timer(3).timeout
	cooldown.erase(body)
	
