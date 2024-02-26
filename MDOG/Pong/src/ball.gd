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

@export var speed = 700

func _ready():
	# Randomly set the velocity of the ball so it goes in a random direction
	# on ready
	randomize()
	velocity.x = [-1,1][randi() % 2] # [-1,1] is an array with 2 vals pick one
	velocity.y = [-0.8,0.8][randi() % 2]

func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.get_normal())
