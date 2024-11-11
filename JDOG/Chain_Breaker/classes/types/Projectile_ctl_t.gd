class_name  projectile_ctl_t
var ENUM = enum_t.new()

var vel_x
var vel_y

var dir
var angle
var damage
var gravity_flg
var projectile_id

var ammo

func _init():
	vel_x         = 0
	vel_y         = 0
	dir           = 0
	angle         = 0
	damage        = 0
	gravity_flg   = 0
	ammo          = 0
	projectile_id = "NONE"
	pass
	
func clear():
	_init()
	pass
