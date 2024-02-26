extends CharacterBody2D
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/11/2024                ##
##                                               ##
## This script is the artificial intelligence    ##
## for the enemy player in the game              ##
##                                               ##
## --------------------------------------------- ##

@export var speed = 10
var ball

func _ready():
	# Get the ball from the list child nodes of the gameScreen scene
	ball = get_parent().find_child("ball")

func _physics_process(delta):
	move_and_collide(Vector2(0,get_opponent_direction()) * speed)

func get_opponent_direction():
	if abs(ball.position.y - position.y) > 25:
		# The ball is below the opponent
		if ball.position.y > position.y: return 1
		# The ball is above the opponent
		else: return -1
	else:
		return 0

