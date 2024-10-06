extends Node

const STATE_NAME = "air_state"

@onready var player = get_parent().get_parent()
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("In air!")

func exit(next_state):
	fsm.change_to(next_state)
	
func _process(_delta):
	# If going up
	if player.velocity.y < 0:
		anim_player.play("Jump")
	# going down
	elif player.velocity.y > 0:
		anim_player.play("Fall")

func _on_player_detection_body_entered(body):
	if (body.name == "Player" and fsm.current_state == fsm.states[STATE_NAME]):
		print("There he is!")
		# Enter chase state
		exit("chase_state")
