extends CharacterBody2D
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/10/2024                ##
## Updated on         : 2/11/2024                ##
##                                               ##
## This script handles the movement of the       ##
## player paddle.                                ##
##                                               ##
## --------------------------------------------- ##

# Using export allows setting value of var in inspector
@export var speed = 20 # How fast to move the player (px/sec)
var screenSize

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().size.y
	# Uncomment if the position on the editor doesn't work in scene
	# global_position = Vector2(50,screenSize / 2) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	
	# move and slide doesn't work for some reason so use this to handle physics movement
	move_and_collide(velocity)
