extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ENUM = enum_t.new()

var interface_ctl_input = interface_ctl_t.new()
var body_ctl_output     = Body_ctl_t.new()

func update_body(input):
	interface_ctl_input = input

func physics_process(delta):
	
	var direction = Input.get_axis("ui_a_key", "ui_d_key")
	var jump      = (interface_ctl_input.action == ENUM.action.JUMP)
	var grounded  = is_on_floor()
	
	#if(grounded):
		#
	#else:

	#print(velocity)
	
#Jumping and falling
	if(grounded && jump):
		velocity.y -= 500.0
		#print(jump)
		
	if(!grounded):
		#print(velocity.y)
		velocity.y += gravity * delta
		
	if(direction):
		velocity.x = direction * 300
	else:
		velocity.x = move_toward(velocity.x, 0, 100)
		
	move_and_slide()
	
	body_ctl_output.grounded  = grounded
	body_ctl_output.vel       = velocity
	body_ctl_output.ascending = (velocity.y < 0.0)
