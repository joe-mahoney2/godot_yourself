class_name Slagman_action_Interp extends Node2D

var animation
var blocking
var overide

var input_cmd = input_t.new()

func ui_interp(input):
	var ani_cmd  = "IDLE"
	var blocking = false
	input_cmd = input
	
	#break down action 
	if(input_cmd.main != "NO_OP"):
		if(input_cmd.main == "MOVE"):
			ani_cmd = "WALK"
		
	if(input_cmd.action != "NO_OP"):
		if(input_cmd.action == "SPACE"):
			ani_cmd = "JUMP"
			blocking = true
	
	if(input_cmd.mod != "NO_OP"):
		if(input_cmd.mod == "SHIFT"):
			if(input_cmd.main == "MOVE"):
				ani_cmd = "RUN"
		
	input_cmd.animation_cmd = ani_cmd
	input_cmd.blocking = blocking
	
	return input_cmd
