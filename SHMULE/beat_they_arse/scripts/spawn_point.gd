extends Marker2D

var croc_scene = preload("res://scenes/enemies/crocodileGoon.tscn")
@onready var timer = $Timer # used by saloon parent node

signal croc_spawned

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_timer_timeout():
	# Spawn a crocodile
	var croc = croc_scene.instantiate()
	croc.position = self.position
	get_parent().add_child(croc)
	emit_signal("croc_spawned")
