extends Node

@onready var player = $"/root/Global".player
@onready var croc = get_node("../../../CrocodileGoon")
@onready var anim_player = get_node("../../AnimationPlayer")

var fsm: StateMachine

func enter():
	print("Hello from chase_state!")

func exit():
	# Go back to the last state
	fsm.back()

func _process(delta):
	# Approach player
	var distance = player.position - self.global_position
	var direction = distance.normalized()
	# flip if we need to
	if direction.x > 0:
		croc.get_node("Sprite2D").flip_h = false
	elif direction.x < 0:
		croc.get_node("Sprite2D").flip_h = true
	# run
	croc.velocity.x = direction.x * croc.SPEED
	anim_player.play("Run")
	print("History: ", fsm.history)
	
	if (abs(distance.x) < croc.ATTACK_RANGE):
		fsm.change_to("jab1_state")

func _on_player_detection_body_exited(body):
	# lost player, return to idle
	print("Where did he go")
	exit()
