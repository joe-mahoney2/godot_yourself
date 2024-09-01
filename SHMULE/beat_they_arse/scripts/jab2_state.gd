extends Node

@onready var player = $"/root/Global".player
@onready var croc = get_node("../../../CrocodileGoon")
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("Hello from jab2_state!")
	# Play attack animation
	anim_player.play("Jab2")

func exit():
	# Go back to the last state
	fsm.back()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Jab2"):
		exit()
