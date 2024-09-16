extends Node

const STATE_NAME = "death_state"

@onready var croc = get_node("../../../CrocodileGoon")
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("Dying")
	croc.velocity.x = 0
	# Play death animation
	anim_player.play("Death")

func exit(next_state):
	fsm.change_to(next_state)
	
func _process(_delta):
	pass

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Death"):
		croc.queue_free()
