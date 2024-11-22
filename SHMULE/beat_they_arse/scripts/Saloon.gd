extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var croc_spawn = $SpawnPoint

var spawn_blocked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	croc_spawn.timer.paused = true


func _on_spawn_point_croc_spawned():
	# Play door opening animation
	anim_player.play("Open")

func _on_player_detection_body_entered(body):
	if (body.name == "Player"):
		croc_spawn.timer.paused = false

func _on_player_detection_body_exited(body):
	if (body.name == "Player"):
		croc_spawn.timer.paused = true


func _on_area_2d_body_entered(body):
	croc_spawn.timer.paused = true

func _on_area_2d_body_exited(body):
	croc_spawn.timer.paused = false
