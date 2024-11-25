extends Node

const STATE_NAME = "Chase"

@onready var player = $"/root/Global".player
@onready var body = $"../../Body"
@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	print("Vulture gonna get you!")
	anim_player.play("Fly")

func _process(delta):
	# Approach player
	vulture.head_toward(player.global_position)
	if (player.dead):
		exit()

func exit():
	fsm.change_to("Return")

func _on_player_detection_body_exited(body):
	if (body.name == "Player" and fsm.current_state == fsm.states[STATE_NAME]):
		exit()
