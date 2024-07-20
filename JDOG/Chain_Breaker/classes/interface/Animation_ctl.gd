class_name Animation_ctl extends AnimatedSprite2D
var ENUM = enum_t.new()

#Inputs
var interface_ctl = interface_ctl_t.new()
var body_ctl      = Body_ctl_t.new()

#local
var spriteAnime

var animation_ctl      = Animation_ctl_t.new()
var animation_ctl_prev = Animation_ctl_t.new()

func update(interface_in ,body_in):
	interface_ctl = interface_in
	body_ctl      = body_in
	set_animations()
	process()
	pass

#SET BASIC ANIMATION OPTION
func set_animations():

	#TAKE INPUT CMD
	if(interface_ctl.active):
		if(interface_ctl.dir == ENUM.dir.RIGHT ||
			interface_ctl.dir == ENUM.dir.LEFT):
			animation_ctl.anime = "RUN"
			
		if(interface_ctl.action == ENUM.action.JUMP):
			animation_ctl.anime = "JUMP"
			
		if(interface_ctl.action == ENUM.action.ATK_MELEE):
			animation_ctl.anime = "SWORD_1"
			
		if(interface_ctl.action == ENUM.action.ATK_RANGED):
			animation_ctl.anime = "THROW_1"
	else:
		animation_ctl.anime = "IDLE"
		
	#YOU ARE FALLING
	if(body_ctl.vel.y > 0):
		animation_ctl.anime = "FALL"
		
		
func process():
	var block      = animation_ctl.block  
	var anime      = animation_ctl.anime
	var action     = interface_ctl.action
	var is_playing = spriteAnime.is_playing()
	var cur_anime  = spriteAnime.animation
	var ascending  = body_ctl.ascending
	
	
	#ACTION HANDLE
	if(action > ENUM.action.NONE):
		spriteAnime.play(anime)
		block = true

	if(block && is_playing == false):
		block = false
		
	if(!block && !ascending):
		spriteAnime.play(anime)
	
		#FACE RIGHT OR LEFT 
	if(interface_ctl.face_left > ENUM.ops.NO_OP):
		spriteAnime.flip_h = interface_ctl.face_left
	
	animation_ctl.block = block
	pass
	
