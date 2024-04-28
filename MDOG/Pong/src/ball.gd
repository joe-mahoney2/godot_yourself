extends CharacterBody2D
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/11/2024                ##
##                                               ##
## This script handles the physics interactions  ##
## and behaviors of the game ball.               ##
##                                               ##
## --------------------------------------------- ##

var win_size : Vector2
const START_SPEED : int = 1200
const ACCEL : int = 50
var speed : int
var dir : Vector2
const MAX_Y_VECTOR : float = 0.6

# Called when the node enters the scene tree for the first time.
func _ready():
	win_size = get_viewport_rect().size
	#randomize start position and direction
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		#if ball hits paddle
		if collider == $"../player1" or collider == $"../opposition":
			speed += ACCEL
			dir = new_direction(collider)
		#if it hits a wall
		else:
			dir = dir.bounce(collision.get_normal())

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	print(pad_y)
	
	#flip the horizontal direction
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (dist / (collider.pHeight / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
