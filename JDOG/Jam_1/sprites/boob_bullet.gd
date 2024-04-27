extends CharacterBody2D

@onready var obj = $Area2D

const SPEED = 500.0

func _init():
	pass

func _process(delta):
	pass
	
func _physics_process(delta):
	move_and_slide()


func _on_area_2d_body_entered(body):
	queue_free()
	pass # Replace with function body.
