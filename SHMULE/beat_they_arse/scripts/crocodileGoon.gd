extends CharacterBody2D

@onready var anim_player = $AnimationPlayer

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
	if player_detected:
		# GO GET HIM
		pass
	else:
		# Run around
		pass


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player_detected = true
		print("There he is! Get him!")
