extends Node

const STATE_NAME = "hurt_state"

@onready var player = $"/root/Global".player
@onready var croc = get_node("../../../CrocodileGoon")
@onready var body = get_node("../../../CrocodileGoon/Body")
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	croc.velocity.x = croc.velocity.x / 2
	anim_player.play("Hurt")

func exit():
	# Go back to the last state
	fsm.back()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Hurt"):
		exit()

func _on_crocodile_goon_hurt():
	fsm.change_to("hurt_state")
