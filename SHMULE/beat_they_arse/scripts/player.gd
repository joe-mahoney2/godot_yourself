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
@onready var anim_sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var anim_state =  anim_tree.get("parameters/playback")
@onready var shoulder_mount = $Body/ShoulderMount
@onready var gun_arm: Node2D = $GunArm
@onready var camera2d: Camera2D = $Camera2D

func _ready():
	anim_tree.active = true
	
func _process(_delta):
	direction = Input.get_axis("ui_left", "ui_right")
	# update direction of animation facing
	update_facing_direction()
	# update the animation we are playing
	update_animation_parameters()

# function that will execute every frame
func _physics_process(delta):
	# add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# handle the jump
	if Input.is_action_just_pressed("ui_accept"):
		jump()
		
	# handle the attack
	if Input.is_action_just_pressed("jab"):
		attack()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func jump():
	if is_on_floor():
		can_double_jump = true
		velocity.y = JUMP_VELOCITY
		var dust = dust_scene.instantiate()
		dust.position = self.position
		dust.position.y += 20
		get_parent().add_child(dust)
	elif can_double_jump:
		can_double_jump = false
		velocity.y = JUMP_VELOCITY

func attack():
	# check if we are in the time window for a second attack
	if anim_sprite.animation == "RightJab" and anim_sprite.frame in [2, 4]:
		anim_tree["parameters/conditions/attack_again"] = true
	elif anim_sprite.animation == "LeftJab" and anim_sprite.frame in [2, 4]:
		anim_tree["parameters/conditions/attack_again"] = true
	else:
		anim_tree["parameters/conditions/attack_again"] = false


func update_animation_parameters():
	# handle attack press
	if (Input.is_action_just_pressed("jab")):
		anim_tree["parameters/conditions/attack_pressed"] = true
		anim_tree["parameters/conditions/is_running"] = false
		anim_tree["parameters/conditions/idle"] = false
	else:
		anim_tree["parameters/conditions/attack_pressed"] = false
		
	# handle horizontal movement
	if (direction):
		# We are running
		anim_tree["parameters/conditions/is_running"] = true
		anim_tree["parameters/conditions/idle"] = false
		# if direction and facing direction differ, play in reverse
		var facing_direction = get_global_mouse_position() - body.global_position
		if facing_direction.x * direction < 0:
			# directions differ, play in reverse
			anim_tree["parameters/conditions/forwards"] = false
			anim_tree["parameters/conditions/backwards"] = true
		elif facing_direction.x * direction > 0:
			# directions are the same, play regular
			anim_tree["parameters/conditions/forwards"] = true
			anim_tree["parameters/conditions/backwards"] = false
	else:
		anim_tree["parameters/conditions/idle"] = true
		anim_tree["parameters/conditions/is_running"] = false
		
	if velocity.y > 0:
		# falling
		anim_tree["parameters/conditions/is_falling"] = true
		anim_tree["parameters/conditions/is_jumping"] = false
		anim_tree["parameters/conditions/on_ground"] = false
	elif velocity.y < 0:
		# jumping
		anim_tree["parameters/conditions/is_jumping"] = true
		anim_tree["parameters/conditions/is_falling"] = false
		anim_tree["parameters/conditions/on_ground"] = false
	else:
		# on ground
		anim_tree["parameters/conditions/on_ground"] = true
		anim_tree["parameters/conditions/is_jumping"] = false
		anim_tree["parameters/conditions/is_falling"] = false


func _on_animation_tree_animation_started(_anim_name):
	anim_tree["parameters/conditions/attack_again"] = false
	
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
