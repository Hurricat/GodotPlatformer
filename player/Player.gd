extends KinematicBody2D

export (int) var walk_speed
export (int) var jump_speed
export (int) var gravity

enum {IDLE, WALK, JUMP, HURT, DEAD}

var state
var anim
var new_anim
var velocity = Vector2()

func _ready():
	hide()

func start(pos):
	position = pos
	show()
	change_state(IDLE)

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = "idle"
		WALK:
			new_anim = "walk"
		JUMP:
			new_anim = "jump"
		DEAD:
			hide()

func hurt():
	pass

func get_input():
	if state == HURT:
		return
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	
	velocity.x = 0
	if right:
		velocity.x += walk_speed
		$Sprite.flip_h = false
	if left:
		velocity.x -= walk_speed
		$Sprite.flip_h = true
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y = -jump_speed
		$JumpSound.play()
	if state == IDLE and velocity.x != 0:
		change_state(WALK)
	if state == WALK and velocity.x == 0:
		change_state(IDLE)
	if state in [IDLE, WALK] and !is_on_floor():
		change_state(JUMP)

func _physics_process(delta):
	velocity.y += gravity
	get_input()
	
	if new_anim != anim:
		anim = new_anim
		$AnimationPlayer.play(anim)
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.is_in_group('enemies'):
			var player_feet = (position + $CollisionShape2D.shape.extents).y
			if player_feet < collision.collider.position.y:
				$StompSound.play()
				collision.collider.take_damage()
				velocity.y = -256
			else:
				hurt()
	
	if state == JUMP and is_on_floor():
		change_state(IDLE)