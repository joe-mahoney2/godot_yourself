class_name Projectile_ctl extends CharacterBody2D
var ENUM = enum_t.new()

var projectile_ctl = projectile_ctl_t.new()

var interface_ctl_input = interface_ctl_t.new()

	
func update(input):
	interface_ctl_input = input
	process()
		
func process():
	if(interface_ctl_input.action == ENUM.action.ATK_RANGED):
		spawn();
	pass

func spawn():
	pass
