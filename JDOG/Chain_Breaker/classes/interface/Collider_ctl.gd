class_name Collider_ctl extends CollisionPolygon2D
var ENUM      = enum_t.new()
var colliders = Collider_ctl_t.new()

func Colider_ctl_add(collider, id):
	var index = colliders.collision_count +1
	
	colliders.collision_id.append(id)
	colliders.collision_pollys.append(collider)
	colliders.collision_count+=1
	pass

func Colider_ctl_update(input):
	pass

