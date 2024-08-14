class_name Body_ctl extends CharacterBody2D

var ENUM = enum_t.new()
var body
var body_shape

var interface_ctl_input = interface_ctl_t.new()
var body_ctl            = Body_ctl_t.new()
	
func Body_ctl_update(input):
	interface_ctl_input = input
	if(interface_ctl_input.active):
		body.update_body(interface_ctl_input)
		
func process(delta):
		body.physics_process(delta)
		
func Body_ctl_output():
	#proform physics actions

	body_ctl = body.body_ctl_output
	return body_ctl
