extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if (playerScore < 15): 
	# TODO: need to make a singleton for playerscore
	_animated_sprite.play("default")
