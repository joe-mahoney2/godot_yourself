extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var obj = $Area2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _init():
	pass
	
func _process(delta):
	_animated_sprite.play("default")

func _physics_process(delta):
	pass

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
	pass # Replace with function body.
