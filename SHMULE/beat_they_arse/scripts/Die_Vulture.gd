extends Node

const STATE_NAME = "Die"

@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	pass

func exit(next_state):
	fsm.change_to(next_state)
