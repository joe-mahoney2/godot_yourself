extends AnimatedSprite2D
var speed
var direction

func _process(delta):
	
	if Input.is_action_just_pressed("ui_right"):
		play("right")

	if Input.is_action_just_pressed("ui_left"):
		play("left")
