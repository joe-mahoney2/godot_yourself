extends "res://scripts/effect.gd"


func _ready():
	# Set property of parent effects class
	ANIMATIONS = ["Poof"]
	# Play the animation
	super._ready()
