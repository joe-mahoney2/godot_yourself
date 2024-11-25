extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spawn_location : Vector2

@onready var body = $Body

func _ready():
	# Register spawn position
	print("Setting spawn to ", self.global_position)
	spawn_location = self.global_position
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
func _physics_process(delta):
	move_and_slide()
	
func damage(value):
	pass
	
func head_toward(tgt_point : Vector2):
	var distance = tgt_point - self.global_position
	# flip if we need to
	if distance.x > 0:
		body.scale.x = -1
	elif distance.x < 0:
		body.scale.x = 1
	# Advance towards player horizontally
	velocity.y = 0
	velocity.x = distance.normalized().x * SPEED
