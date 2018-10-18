extends Area2D

signal pickup

func _ready():
	pass

func init(pos):
	position = pos

func _on_Collectible_body_entered(body):
	emit_signal('pickup')
	queue_free()
