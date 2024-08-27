class_name Collider_ctl extends CollisionPolygon2D
var ENUM      = enum_t.new()
var colliders = Collider_ctl_t.new()
var ac        = Animation_ctl.new()
var ic        = interface_ctl_t.new()

var tag

func add(collider, id, tag_in):
	tag = tag_in
	
	colliders.collision_id.append(id)
	colliders.collision_pollys.append(collider)
	colliders.collision_count+=1
	collider.disabled = true
	pass
	
func update(anime_ctrl):
	ac = anime_ctrl
	ic = ac.interface_ctl
	process()
	pass

func process():
	#player animations collider (tbd)
	if(tag == "player"):
		pass

	#weapon colliders (tbd)
	if(tag == "weapon"):
		pass
		
	#directional
	colliders.set_collider_direction(ic.dir)
	pass

func set_active(id):
	colliders.set_active_collider(id)
	pass

func debug():
	colliders.debug()
	pass
