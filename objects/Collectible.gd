extends Area2D

signal pickup

func _ready():
	pass

func init(pos):
	position = pos

func _on_Collectible_body_entered(body):
	$CollisionShape2D.disabled = true
	$PickupSound.play()
	emit_signal('pickup')
	hide()


func _on_PickupSound_finished():
	queue_free()
