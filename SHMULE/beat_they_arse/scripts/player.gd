extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# jump count
var can_double_jump = true
var direction = 0

var dust_scene = preload("res://scenes/effects/dust.tscn")

# get the gravity from the project settings to be synced with RigidBody  nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var body = $Body
@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var shoulder_mount = $Body/ShoulderMount
@onready var gun_arm: Node2D = $GunArm
@onready var camera2d: Camera2D = $Camera2D

# Things get serious below this comment. THe above stuff is unserious
func _ready():
	$"/root/Global".register_player(self)
	anim_tree.active = true

func _process(_delta):
	direction = Input.get_axis("ui_left", "ui_right")
	# update direction of animation facing
	update_facing_direction()

# function that will execute every frame
func _physics_process(delta):
	anim_tree.advance(delta)
	move_and_slide()
	# Check if we are on the ground
	if is_on_floor():
		# Reset double jump
		can_double_jump = true
		# Set animation input
		anim_tree.set("parameters/in_air_state/transition_request", "ground")
	else:
		# add gravity
		velocity.y += gravity * delta
		# set animation input
		anim_tree.set("parameters/in_air_state/transition_request", "air")

	# handle the jump
	if Input.is_action_just_pressed("ui_accept"):
		jump()
	elif velocity.y > 0:
		# we are falling
		anim_tree.set("parameters/in_air/transition_request", "falling")

	# handle the attack
	if Input.is_action_just_pressed("jab"):
		attack()

	if direction:
		# We have L/R inputs!
		velocity.x = direction * SPEED
		anim_tree.set("parameters/movement/transition_request", "run")
		# potentially reverse animation if walking backwards
		update_time_scale()
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED)
		anim_tree.set("parameters/movement/transition_request", "idle")

func jump():
	if is_on_floor():
		# JUMP!
		can_double_jump = true
		velocity.y = JUMP_VELOCITY
		spawn_dust()
		anim_tree.set("parameters/in_air/transition_request", "jumping")
	elif can_double_jump:
		# JUMP!
		can_double_jump = false
		velocity.y = JUMP_VELOCITY
		anim_tree.set("parameters/in_air/transition_request", "jumping")

func attack():
	pass
	## check if we are in the time window for a second attack
	#if anim_sprite.animation == "RightJab" and anim_sprite.frame in [2, 4]:
		#anim_tree["parameters/conditions/attack_again"] = true
	#elif anim_sprite.animation == "LeftJab" and anim_sprite.frame in [2, 4]:
		#anim_tree["parameters/conditions/attack_again"] = true
	#else:
		#anim_tree["parameters/conditions/attack_again"] = false

func update_time_scale():
	var facing_direction = get_global_mouse_position() - body.global_position
	if facing_direction.x * direction < 0:
		# different directions, reverse run
		anim_tree.set("parameters/movement_time/scale", -1)
	elif facing_direction.x * direction > 0:
		# same directions, set timeScale to 1
		anim_tree.set("parameters/movement_time/scale", 1)
	
func update_facing_direction():
	# Check if mouse is to left or right of player
	var difference = get_global_mouse_position() - body.global_position
	if difference.x > 0:
		body.scale.x = 1
		gun_arm.position.x = 13
		gun_arm.image.flip_v = false
	elif difference.x < 0:
		body.scale.x = -1
		gun_arm.position.x = -13
		gun_arm.image.flip_v = true

func spawn_dust():
	var dust = dust_scene.instantiate()
	dust.position = self.position
	dust.position.y += 20
	get_parent().add_child(dust)
