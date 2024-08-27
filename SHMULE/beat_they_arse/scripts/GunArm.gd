extends Node2D

@onready var character_body: CharacterBody2D = get_parent()
@onready var image: Sprite2D = $Image
@onready var tip: Marker2D = $GunTip

var muzzle_flash = preload("res://scenes/effects/muzzle_flash.tscn")
var direction: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_arm_rotation()
	
	if Input.is_action_just_pressed("left_click"):
		# spawn muzzle flare
		spawn_flash()
		# add player knockback
		character_body.velocity -= direction * 200
		print(character_body.velocity)
		

func _update_arm_rotation():
	var shoulder_position = character_body.shoulder_mount.global_position

	# get mouse position in global coords
	var mouse_position = get_global_mouse_position()
	
	# Calculate the direction vector from the shoulder to the mouse
	direction = (mouse_position - shoulder_position).normalized()
	
	# Calculate the rotation angle
	var angle = direction.angle()
	
	# Apply the rotation to the arm
	rotation = angle
	
func spawn_flash():
	var flash = muzzle_flash.instantiate()
	flash.position = tip.position
	self.add_child(flash)
