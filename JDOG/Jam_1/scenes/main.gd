extends Node2D
@onready var map = $TileMap
@onready var spawn = $spawn_zone
@onready var spawn_area = $spawn_zone/SPAWN_AREA

var water_boi = preload("res://sprites/water_sprite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawner()
	pass


func _on_boob_man_shoot_bullet(Bullet, direction, location):
	var player_bullet = Bullet.instantiate()
	add_child(player_bullet)
	player_bullet.position = location
	player_bullet.velocity = direction - location
	
	var norm_x = 0
	var norm_y = 0
	var theta  = 0.0
	
	theta = atan2(player_bullet.velocity.x, player_bullet.velocity.y)
	norm_x = 400 * sin(theta)
	norm_y = 400 * cos(theta)
	
	var norm_vel = Vector2(norm_x,norm_y)
	player_bullet.velocity = norm_vel
	
	pass

var spawn_mob

func spawner():
	
	if(spawn_mob):
		var spawn_center = spawn_area.global_position
		var spawn_shape = spawn_area.get_shape()
		var spawn_rect = spawn_shape.get_rect()
		
		var plus_minus_x = spawn_rect.size.x/2
		var plus_minus_y = spawn_rect.size.y/2
		
		var x_transform = randf_range(-1.0,1.0) * plus_minus_x
		var y_transform = randf_range(-1.0,1.0) * plus_minus_y
	
		var player_bullet = water_boi.instantiate()
		add_child(player_bullet)
		player_bullet.position = Vector2(spawn_center.x + x_transform, spawn_center.y + y_transform)
		spawn_mob = 0
		pass


func _on_timer_timeout():
	spawn_mob = 1
	pass # Replace with function body.
