class_name Collider_ctl_t extends CollisionPolygon2D
var ENUM = enum_t.new()     #global enum holder 
var collision_pollys        #collision polly objects
var collision_id            #string id of the collider 
var collision_count         #number of controlled colliders
var direction               #current facing direction -1 = left

func _init():
	collision_count  = 0;
	collision_pollys = []
	collision_id     = []
	direction        = 1
	pass

func set_active_collider(id):
	for i in collision_count:
		if(collision_id[i] == id):
			collision_pollys[i].disabled = false
		else:
			collision_pollys[i].disabled = true
	pass

func set_temp_collider(id, state):
	for i in collision_count:
		if(collision_id[i] == id):
			collision_pollys[i].disabled = state
	pass

func set_collider_direction(dir):
	if(dir == ENUM.dir.RIGHT):
		direction = 1
	elif(dir == ENUM.dir.LEFT):
		direction = -1
		
	for i in collision_count:
		collision_pollys[i].scale.x = direction 
	pass

func debug():
	for i in collision_count:
		print("Collider_ctl_t::DBG :" + collision_id[i])
		print(!collision_pollys[i].disabled)
	pass
