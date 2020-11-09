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
var lives = 3

signal animate

var boosted = false

func _physics_process(delta):
	if position.y > WORLD_LIMIT:
		end_game()
	apply_gravity()
	jump()
	move()
	animate()
	# workaround for the boost() not working consistently
	if boosted:
		motion.y = -(JUMP_SPEED * boost_multiplier)
		boosted = false
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
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1 # bounce off the ceiling
	else:
		motion.y += GRAVITY


func animate():
	emit_signal("animate", motion)


func end_game():
	get_tree().change_scene("res://Levels/EndGame.tscn")


func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y = -JUMP_SPEED
	lives -= 1
	#$AudioStreamPlayer.stream = load("res://SFX/pain.ogg")
	$PainSFX.play()
	if lives < 0:
		end_game()


func boost():
	print("boost")
	boosted = true
	# Doesn't work for some reason
	#position.y -= 10
	#yield(get_tree(), "idle_frame")
	#motion.y = -(JUMP_SPEED * boost_multiplier)
	#print(motion.y)










