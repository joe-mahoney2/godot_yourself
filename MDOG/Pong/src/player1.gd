extends Area2D
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/10/2024                ##
##                                               ##
## This script simply closes the application on  ##
## exit button pressed.                          ##
##                                               ##
## TODO: Make the code header less stupid :P     ##
## --------------------------------------------- ##

# Using export allows setting value of var in inspector
@export var speed = 1000 # How fast to move the player (px/sec)
var screen_size # Size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
		
	
	if velocity.length() > 0:
		velocity.normalized() * speed
	
	global_position += velocity * delta
	global_position.y = clamp(global_position.y, 0, screen_size.y) 
	print("position: ",position)
