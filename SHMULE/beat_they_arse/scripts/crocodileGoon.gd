extends CharacterBody2D

@onready var anim_player = $AnimationPlayer
@onready var player = get_node("../Player")
@onready var health_bar = $HealthBar

var SPEED = 150
var downed = false
var ATTACK_RANGE = 50
var health : int
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal hurt
signal dead

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 3
	health_bar.init_health(health)

func _physics_process(delta):
	# Gravity for Mr Crocodile
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(value: int):
	health -= value
	if not downed:
		emit_signal("hurt")
		health_bar._set_health(health)
	# if health is zero or below
	if (health <= 0):
		die()
	else:
		# update health bar
		print("updating health bar")
		

func die():
	print("i am dead")
	downed = true
	emit_signal("dead")
