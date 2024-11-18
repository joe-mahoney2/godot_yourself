extends Node2D

@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_spawn_point_croc_spawned():
	# Play door opening animation
	anim_player.play("Open")
