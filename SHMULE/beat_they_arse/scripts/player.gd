extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_double_jump = true
var direction = 0
var dead = false
var in_air = false
var bullets : int = 6

var dust_scene = preload("res://scenes/effects/dust.tscn")

# get the gravity from the project settings to be synced with RigidBody  nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var health = $"/root/Global".MAX_HEALTH_PLAYER
@onready var body = $Body
@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var shoulder_mount = $Body/ShoulderMount
@onready var gun_arm: Node2D = $GunArm
@onready var camera2d: Camera2D = $Camera2D
@onready var health_bar = $Camera2D/CanvasGroup/HealthBar

# Things get serious below this comment. THe above stuff is unserious
func _ready():
	$"/root/Global".register_player(self)
	anim_tree.active = true
	health_bar.init_health(health)

func _process(_delta):
	if dead:
		return
	direction = Input.get_axis("ui_left", "ui_right")
	# update direction of animation facing
	update_facing_direction()

# function that will execute every frame
func _physics_process(delta):
	move_and_slide()
	if dead:
		# apply physcis only and quit
		velocity.y += gravity * delta
		return
	# Check if we are on the ground
	if is_on_floor():
		# Reset double jump
		can_double_jump = true
		# Set animation input
		anim_tree.set("parameters/in_air_state/transition_request", "ground")
		# Begin hack job
		if (in_air): # we just landed
			in_air = false
			anim_tree.active = false
		else: # We have BEEN landed
			anim_tree.active = true # end hack job
	else:
		in_air = true
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
	anim_tree.set("parameters/OneShot 2/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
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
	_update_arm_rotation()

func _update_arm_rotation():
	# get mouse position in global coords
	var mouse_position = get_global_mouse_position()
	# Calculate the direction vector from the shoulder to the mouse
	var mouse_direction = (mouse_position - shoulder_mount.global_position).normalized()
	
	# Calculate the rotation angle
	var angle = mouse_direction.angle()
	
	# Apply the rotation to the arm
	gun_arm.rotation = angle

func damage(value: int):
	health -= value
	if not dead:
		health_bar._set_health(health)
	# if health is zero or below
	if (health <= 0):
		die()
	else:
		# play hurt
		anim_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func add_health(value: int):
	health += value
	health = min($"/root/Global".MAX_HEALTH_PLAYER, health)
	health_bar._set_health(health)
	

func die():
	# set dead var
	velocity = Vector2(0,0)
	dead = true
	# disable the animation tree
	anim_tree.active = false;
	# play death animation
	print("Playing death animation")
	anim_player.play("Death")
	# Game is over
	$Camera2D/DeathLabel.visible = true

func spawn_dust():
	var dust = dust_scene.instantiate()
	dust.position = self.position
	dust.position.y += 20
	get_parent().add_child(dust)

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Death"):
		anim_player.play("GhostHover")


func _on_punch_box_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage(2)
