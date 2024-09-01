extends Node

@onready var player = $"/root/Global".player
@onready var croc = get_node("../../../CrocodileGoon")
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("Hello from jab1_state!")
	# Play attack animation
	anim_player.play("Jab1")

func exit():
	# Go back to the last state
	fsm.back()



func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if (anim_name == "Jab1"):
		# if player is still in striking range
		var distance = player.position - self.global_position
		if (abs(distance.x) < croc.ATTACK_RANGE):
			# play jab2
			fsm.change_to("jab2_state")
		else:
			# Player out of range, conclude
			exit()
