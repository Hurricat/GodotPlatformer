extends KinematicBody2D

export (int) var speed
export (int) var gravity

var velocity = Vector2()
var facing = 1

func init(pos):
	position = pos

func _physics_process(delta):
	velocity.y += gravity
	velocity.x = facing * speed
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.name == 'Player':
			collision.collider.hurt()
		if collision.normal.x != 0:
			facing = sign(collision.normal.x)

func take_damage():
	$AnimationPlayer.play('dead')
	$CollisionShape2D.disabled = true
	set_physics_process(false)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'dead':
		queue_free()
