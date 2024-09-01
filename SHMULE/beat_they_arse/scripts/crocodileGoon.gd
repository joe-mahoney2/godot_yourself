extends CharacterBody2D

@onready var anim_player = $AnimationPlayer
@onready var player = get_node("../Player")

var SPEED = 150
var ATTACK_RANGE = 50
var player_detected = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("Idle")

func _physics_process(delta):
	# Gravity for Mr Crocodile
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
