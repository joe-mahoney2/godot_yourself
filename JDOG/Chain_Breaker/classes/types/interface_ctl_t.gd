class_name  interface_ctl_t
var ENUM = enum_t.new()

var dir
var face_left
var action
var mod
var active

func _init():
	dir       = ENUM.dir.DOWN
	face_left = false
	action    = ENUM.action.NONE
	mod       = ENUM.mod.NONE
	active    = false
	
func clear():
	_init()
	pass
