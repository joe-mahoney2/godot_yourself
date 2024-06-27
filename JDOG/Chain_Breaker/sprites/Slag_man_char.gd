extends Node2D

#Systems
var interface_ctl      = Interface_ctl.new()
var interface_body_ctl = Body_ctl.new()

var animation_ctl      = Animation_ctl.new()  

#Variables
var delta_t
var interface_ctl_out = preload("res://classes/types/interface_ctl_t.gd")
var body_ctl_out      = preload("res://classes/types/Body_ctl_t.gd")

func _ready():
	interface_body_ctl.body       = $CharacterBody2D
	interface_body_ctl.body_shape = $CharacterBody2D/CollisionShape2D
	animation_ctl.spriteAnime     = $AnimatedSprite2D
	pass
	
func _process(delta):
	delta_t = delta
	top_frame()
	main_process()
	bot_frame()
	pass

#get all inputs 
func top_frame():
	interface_ctl_out = interface_ctl.process()
	interface_body_ctl.Body_ctl_update(interface_ctl_out)
	pass

func main_process():
	interface_body_ctl.process(delta_t)
	body_ctl_out = interface_body_ctl.Body_ctl_output()
	pass

func bot_frame():
	animation_ctl.update(interface_ctl_out, body_ctl_out)
	pass
	
func debug():
	pass
