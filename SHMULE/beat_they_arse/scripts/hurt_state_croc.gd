extends Node

const STATE_NAME = "hurt_state"

@onready var player = $"/root/Global".player
@onready var croc = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	croc.velocity.x = croc.velocity.x / 2
	anim_player.play("Hurt")

func exit():
	if fsm.history[fsm.history.size() - 1] == "idle_state":
		# we have to pop and then go to chase
		fsm.back()
		fsm.change_to("chase_state")
	# Go back to the last state
	else:
		fsm.back()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Hurt"):
		exit()

func _on_crocodile_goon_hurt():
	fsm.change_to("hurt_state")
