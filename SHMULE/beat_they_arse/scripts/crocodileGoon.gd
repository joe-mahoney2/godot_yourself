extends CharacterBody2D

@onready var anim_player = $AnimationPlayer
@onready var player = $"/root/Global".player
@onready var health_bar = $HealthBar

var SPEED = 150
var downed = false
var ATTACK_RANGE = 50
var health : int
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var heart_scene = preload("res://scenes/effects/heart.tscn")

signal hurt
signal dead

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 5
	health_bar.init_health(health)
	health_bar.visible = false

func _physics_process(delta):
	# Gravity for Mr Crocodile
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(value: int):
	health_bar.visible = true
	health -= value
	if not downed:
		emit_signal("hurt")
		health_bar._set_health(health)
	# if health is zero or below
	if (health <= 0):
		die()

func die():
	velocity = Vector2(0,0)
	print("i am dead")
	downed = true
	# Potentially spawn heart
	if randf() < 0.25:
		# spawn heart
		spawn_heart()
	emit_signal("dead")

func spawn_heart():
	var heart = heart_scene.instantiate()
	heart.position = self.position
	get_parent().add_child(heart)
