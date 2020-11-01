extends KinematicBody2D
# KinematicBody2D is intended to be controller by the player

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 300
const UP = Vector2(0,-1)
const JUMP_SPEED = 5000

func _physics_process(delta):
	apply_gravity()
	jump()
	move()	
	animate()
	move_and_slide(motion, UP)


func jump():
	var isJumpPressed = Input.is_action_pressed("jump")
	if isJumpPressed and is_on_floor():
		motion.y = -JUMP_SPEED


func move():
	var isLeftPressed = Input.is_action_pressed("left")
	var isRightPressed = Input.is_action_pressed("right")
	
	if isLeftPressed and not isRightPressed:
		motion.x = -SPEED
	elif isRightPressed and not isLeftPressed:
		motion.x = SPEED
	else:
		motion.x = 0


func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY
		
		
func animate():
	if motion.y < 0:
		$AnimatedSprite.play("jump");
	elif motion.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif motion.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	
