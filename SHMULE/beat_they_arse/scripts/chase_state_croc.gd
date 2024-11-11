extends Node

const STATE_NAME = "chase_state"

@onready var player = $"/root/Global".player
@onready var croc = get_parent().get_parent()
@onready var body = $"../../Body"
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	anim_player.play("Run")

func exit():
	# Go back to the last state
	fsm.back()

func _process(delta):
	# Approach player
	var distance = player.global_position - self.global_position
	# flip if we need to
	if distance.x > 0:
		body.scale.x = 1
	elif distance.x < 0:
		body.scale.x = -1
	# run
	croc.velocity.x = distance.normalized().x * croc.SPEED
	if (player.dead):
		exit()

func _on_player_detection_body_exited(body):
	# lost player, return to idle
	if (body.name == "Player" and fsm.current_state == fsm.states[STATE_NAME]):
		exit()

func _on_jab_range_body_entered(body):
	# Check if state has changed because we can 
	if (body.name == "Player" and fsm.current_state == fsm.states["chase_state"]):
		fsm.change_to("jab_state")
