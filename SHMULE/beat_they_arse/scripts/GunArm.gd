extends Node2D

@onready var character_body: CharacterBody2D = get_parent()
@onready var image: Sprite2D = $Image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_arm_rotation()

func _update_arm_rotation():
	var shoulder_position = character_body.shoulder_mount.global_position

	# get mouse position in global coords
	var mouse_position = get_global_mouse_position()
	
	# Calculate the direction vector from the shoulder to the mouse
	var direction = (mouse_position - shoulder_position).normalized()
	
	# Calculate the rotation angle
	var angle = direction.angle()
	
	# Apply the rotation to the arm
	rotation = angle
