extends "res://scripts/effect.gd"


func _ready():
	# Set property of parent effects class
	ANIMATIONS = ["Flash1", "Flash2", "Flash3"]
	# Play the animation
	super._ready()
