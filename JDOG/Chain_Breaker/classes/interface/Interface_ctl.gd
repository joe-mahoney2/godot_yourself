class_name Interface_ctl
var ENUM          = enum_t.new()
var interface_ctl = interface_ctl_t.new()

func _init():
	pass

func process():
#GET DIRECTION
	var ic = ENUM.dir.NONE
	if(Input.is_action_pressed("ui_w_key")):
		ic = ENUM.dir.UP
	elif(Input.is_action_pressed("ui_s_key")):
		ic = ENUM.dir.DOWN
	elif(Input.is_action_pressed("ui_a_key")):
		ic = ENUM.dir.LEFT
	elif(Input.is_action_pressed("ui_d_key")):
		ic = ENUM.dir.RIGHT
		
#GET ACTION
	var ac = ENUM.action.NONE
	if(Input.is_action_just_pressed("ui_space")):
		ac = ENUM.action.JUMP
		
	if(Input.is_action_just_pressed("ui_right_click")):
		ac = ENUM.action.ATK_MELEE
		
	if(Input.is_action_just_pressed("ui_left_click")):
		ac = ENUM.action.ATK_RANGED
		
#GET MODIFIER
	var mod = ENUM.mod.NONE
	if(Input.is_action_pressed("ui_shift")):
		mod = ENUM.mod.SHIFT
		
#GET ACTIVE INPUT
	var act = false
	if(ic || ac || mod):
		act = true
			
	interface_ctl.dir    = ic
	interface_ctl.action = ac
	interface_ctl.mod    = mod
	interface_ctl.active = act
	
#GET FACE LEFT
	if(ic == ENUM.dir.LEFT && act):
		interface_ctl.face_left = 1
	elif(ic == ENUM.dir.RIGHT && act):
		interface_ctl.face_left = 0
	elif(!act):
		interface_ctl.face_left = ENUM.ops.NO_OP
	
	return interface_ctl
