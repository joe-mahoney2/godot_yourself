extends StaticBody2D
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
@export var speed = 700 # How fast to move the player (px/sec)
var winHeight : int
var pHeight : int

# Called when the node enters the scene tree for the first time.
func _ready():
	winHeight = get_viewport_rect().size.y
	pHeight = $paddleCollision.get_shape().get_rect().size.y
	# Uncomment if the position on the editor doesn't work in scene
	# global_position = Vector2(50,screenSize / 2) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_down"):
		position.y += speed * delta
	if Input.is_action_pressed("move_up"):
		position.y -= speed * delta
	
	position.y = clamp(position.y, pHeight /2 , winHeight - pHeight / 2 )
