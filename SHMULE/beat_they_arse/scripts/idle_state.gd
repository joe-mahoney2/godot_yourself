extends Node

@onready var croc = get_node("../../../CrocodileGoon")
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("Idling!")

func exit(next_state):
	fsm.change_to(next_state)
	
func _process(_delta):
	# Play idle animation
	anim_player.play("Idle")
	# just stand around
	croc.velocity.x = 0

func _on_player_detection_body_entered(body):
	if (body.name == "Player"):
		print("There he is!")
		# Enter chase state
		exit("chase_state")
