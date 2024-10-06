extends Node

const STATE_NAME = "idle_state"

@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("Idling!")
	# Play idle animation
	anim_player.play("Idle")

func exit(next_state):
	fsm.change_to(next_state)
