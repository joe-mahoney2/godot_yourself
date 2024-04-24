extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _camara = $Camera2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _init():
	pass

func _process(delta):
	animation_process()
	physics_process()

func physics_process():
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_h = Input.get_axis("ui_left", "ui_right")
	var direction_v = Input.get_axis("ui_up", "ui_down")
	
	if direction_h or direction_v:
		velocity.x = direction_h * SPEED
		velocity.y = direction_v * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

enum dir {
	UP,
	DOWN,
	RIGHT,
	LEFT,
}

var action_to_play = "face_down"
var previous_action = "your_mom_gay"
var cur_direction = 0

func animation_process():
	
	#Moveing
	if(Input.is_action_pressed("ui_right")):
		action_to_play = "move_right"
		cur_direction = dir.RIGHT
	elif(Input.is_action_pressed("ui_left")):
		action_to_play = "move_left"
		cur_direction = dir.LEFT
	elif(Input.is_action_pressed("ui_up")):
		action_to_play = "move_up"
		cur_direction = dir.UP
	elif(Input.is_action_pressed("ui_down")):
		action_to_play = "move_down"
		cur_direction = dir.DOWN
	
	#Idel
	if(Input.is_action_just_released("ui_right")):
		action_to_play = "face_right"
	elif(Input.is_action_just_released("ui_left")):
		action_to_play = "face_left"
	elif(Input.is_action_just_released("ui_up")):
		action_to_play = "face_up"
	elif(Input.is_action_just_released("ui_down")):
		action_to_play = "face_down"
		
	#Shooting
	if(Input.is_action_pressed("ui_left_click")):
		if(cur_direction == dir.UP):
			action_to_play = "shoot_up"
		elif(cur_direction == dir.DOWN):
			action_to_play = "shoot_down"
		elif(cur_direction == dir.RIGHT):
			action_to_play = "shoot_right"
		elif(cur_direction == dir.LEFT):
			action_to_play = "shoot_left"
			
	if(Input.is_action_pressed("left_click")):
		action_to_play = previous_action
	
	#play animation
	_animated_sprite.play(action_to_play)
	
	if(previous_action != action_to_play):
		previous_action = action_to_play
