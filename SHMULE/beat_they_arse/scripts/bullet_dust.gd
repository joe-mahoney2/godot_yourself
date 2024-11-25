extends "res://scripts/effect.gd"


func _ready():
	# Set property of parent effects class
	ANIMATIONS = ["Puff1", "Puff2", "Puff3"]
	# Play the animation
	super._ready()
