extends StaticBody2D
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/11/2024                ##
##                                               ##
## This script is the artificial intelligence    ##
## for the enemy player in the game              ##
##                                               ##
## --------------------------------------------- ##

@export var speed = 500
var ball
var pHeight : int
var ball_pos : Vector2
var dist : int
var move_by : int
var win_height : int

func _ready():
	# Get the ball from the list child nodes of the gameScreen scene
	ball = get_parent().find_child("ball")
	win_height = get_viewport_rect().size.y
	pHeight = $paddleCollision.get_shape().get_rect().size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move paddle towards ball
	ball_pos = $"../ball".position
	dist = position.y - ball_pos.y
	
	if abs(dist) > speed * delta:
		move_by = speed * delta * (dist / abs(dist))
	else:
		move_by = dist

	position.y -= move_by
	
	#limit paddle movement to window
	position.y = clamp(position.y, pHeight / 2, win_height - pHeight / 2)

