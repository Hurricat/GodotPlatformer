extends Area2D

signal pickup

var frames = {'bronze': 274, 'silver': 275, 'gold': 276}
var value = 0

func _ready():
	pass

func init(type, pos):
	value = frames[type] - 273
	$Sprite.frame = frames[type]
	position = pos

func _on_Collectible_body_entered(body):
	emit_signal('pickup')
	queue_free()
