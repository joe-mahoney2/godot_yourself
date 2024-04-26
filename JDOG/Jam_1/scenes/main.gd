extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_boob_man_shoot_bullet(Bullet, direction, location):
	var player_bullet = Bullet.instantiate()
	add_child(player_bullet)
	player_bullet.position = location
	player_bullet.velocity = direction - location
	
	var norm_x = 0
	var norm_y = 0
	var theta  = 0.0
	
	
	
	print(player_bullet.velocity)
	print(rad_to_deg(atan2(player_bullet.velocity.x, player_bullet.velocity.y)))
	
	theta = atan2(player_bullet.velocity.x, player_bullet.velocity.y)
	norm_x = 400 * sin(theta)
	norm_y = 400 * cos(theta)
	
	var norm_vel = Vector2(norm_x,norm_y)
	player_bullet.velocity = norm_vel
	
	pass
	#player_bullet
	#player_bullet
