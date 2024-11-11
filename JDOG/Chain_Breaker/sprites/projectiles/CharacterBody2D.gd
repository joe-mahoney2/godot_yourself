extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ENUM    = enum_t.new()

var projectile_ctl = Projectile_ctl.new()

func set_projectile_data(projectile_ctl_in):
	pass

func _physics_process(delta):
	velocity.x = 500
	velocity.y = 0
	move_and_slide()
