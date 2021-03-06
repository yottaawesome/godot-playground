extends KinematicBody2D
# KinematicBody2D is intended to be controller by the player

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 150
# A note on Godot's screen coordinates
# (0,0) is top left corner of the screen, and positive y-axis
# is down the screen (negative is obviously up)
const UP = Vector2(0,-1)
const JUMP_SPEED = 3500
const WORLD_LIMIT = 4000

export var boost_multiplier = 1.5

signal animate

var boosted = false

func _physics_process(delta):
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	apply_gravity()
	jump()
	move()
	animate()
	# workaround for the boost() not working consistently
	# update: fixed, tutorial code was buggy
	#if boosted:
	#	motion.y = -(JUMP_SPEED * boost_multiplier)
	#	boosted = false
	move_and_slide(motion, UP)


func jump():
	var isJumpPressed = Input.is_action_pressed("jump")
	if isJumpPressed and is_on_floor():
		motion.y = -JUMP_SPEED
		#$AudioStreamPlayer.stream = load("res://SFX/jump1.ogg")
		$JumpSFX.play()


func move():
	var isLeftPressed = Input.is_action_pressed("left")
	var isRightPressed = Input.is_action_pressed("right")
	
	if isLeftPressed and not isRightPressed:
		motion.x = -SPEED
		$Camera2D.position.x = -1000
	elif isRightPressed and not isLeftPressed:
		motion.x = SPEED
		$Camera2D.position.x = 1000
	else:
		motion.x = 0


func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	elif is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1 # bounce off the ceiling
	else:
		motion.y += GRAVITY
	
	#if is_on_floor():
	#	motion.y = 0
	#elif is_on_ceiling():
	#	motion.y = 1 # bounce off the ceiling
	#else:
	#	motion.y += GRAVITY


func animate():
	emit_signal("animate", motion)


func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y = -JUMP_SPEED
	#$AudioStreamPlayer.stream = load("res://SFX/pain.ogg")
	$PainSFX.play()


func boost():
	print("boost")
	
	#boosted = true
	position.y -= 10
	yield(get_tree(), "idle_frame")
	motion.y = -JUMP_SPEED * boost_multiplier










