class_name Collider_ctl_t extends CollisionPolygon2D

var collision_pollys
var collision_id
var collision_count

func _init():
	collision_count = 0;
	collision_pollys = []
	collision_id     = []
	pass

func set_active_collider(id):
	for i in collision_count:
		if(collision_id[i] == id):
			collision_pollys[i].disabled = false
		else:
			collision_pollys[i].disabled = true
	pass
