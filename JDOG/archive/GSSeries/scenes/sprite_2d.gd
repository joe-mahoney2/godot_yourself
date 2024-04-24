extends Sprite2D

var speed = 400
var angular_speed = PI
var enable = 0
var time

signal damage(damage,hp)
	
func _init():
	print("if your reading this your gay")
	
func _process(delta):
	#rotation += angular_speed  * delta
	#
	#var velocity = Vector2.UP.rotated(rotation) * speed
	#position += velocity * delta
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	rotation += angular_speed * direction * delta

	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.UP.rotated(rotation) * (-1.0) * speed

	if(enable):
		position += velocity * delta

func _on_button_toggled(toggled_on):
	enable^=1
	print(enable)

func _on_epic_timer_timeout():
	damage.emit(5,5)
	print("epic timer timeout\n")


func _on_damage(damage, hp):
	print("periodic damage bitch")
	

