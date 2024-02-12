extends AnimatedSprite2D
var speed
var direction
var xy

func _init():
	speed = 400
	direction = 0;
	xy = position

func _process(delta):

	if Input.is_action_just_pressed("ui_right"):
		play("move_right")
		direction = 1
		
		
	if Input.is_action_just_pressed("ui_left"):
		play("move_left")
		direction = -1

	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		self.position.x += direction*speed*delta
