extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spawn_location : Vector2
var health : int
var is_dead : bool

@onready var body = $Body
@onready var body_col_shape = $CollisionShape2D
@onready var health_bar = $HealthBar

signal hurt
signal dead
signal player_in_range

func _ready():
	# Register spawn position
	spawn_location = self.global_position
	health = 2
	health_bar.init_health(health)
	health_bar.visible = false
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

func _physics_process(delta):
	move_and_slide()
	
func damage(value: int):
	# if health bar isn't showing, display
	health_bar.visible = true
	health -= value
	if not is_dead:
		emit_signal("hurt")
		health_bar._set_health(health)
	# if health is zero or below
	if (health <= 0):
		die()
	
func head_toward(tgt_point : Vector2):
	var distance = tgt_point - self.global_position
	in_range_check(distance)
	# flip if we need to
	if distance.x > 0:
		body.scale.x = -1
		body_col_shape.scale.x = -1
	elif distance.x < 0:
		body.scale.x = 1
		body_col_shape.scale.x = 1
	# Advance towards player horizontally
	velocity.y = 0
	velocity.x = distance.normalized().x * SPEED
	
func head_straight_to(tgt_point : Vector2):
	var distance = tgt_point - self.global_position
	# flip if we need to
	if distance.x > 0:
		body.scale.x = -1
		body_col_shape.scale.x = -1
	elif distance.x < 0:
		body.scale.x = 1
		body_col_shape.scale.x = 1
	# Advance towards player
	velocity = distance.normalized() * SPEED

func die():
	is_dead = true
	emit_signal("dead")

func in_range_check(dist : Vector2):
	if (abs(dist.x) < 100):
		emit_signal("player_in_range")
