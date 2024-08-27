extends Node2D

@onready var character_body: CharacterBody2D = get_parent()
@onready var image: Sprite2D = $Image
@onready var tip: Marker2D = $GunTip
@onready var ray: RayCast2D = $RayCast2D

var muzzle_flash = preload("res://scenes/effects/muzzle_flash.tscn")
var bullet_dust = preload("res://scenes/effects/bullet_dust.tscn")
var direction: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_arm_rotation()
	
	if Input.is_action_just_pressed("left_click"):
		# spawn muzzle flare
		spawn_flash()
		# add player knockback (remove for now)
		# character_body.velocity -= direction * 200
		
		# check for bullet collision
		if ray.is_colliding():
			# spawn dust at point
			spawn_bullet_dust()
		

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
	
func spawn_bullet_dust():
	var bull_dust = bullet_dust.instantiate()
	bull_dust.global_position = ray.get_collision_point()
	get_parent().get_parent().add_child(bull_dust)
