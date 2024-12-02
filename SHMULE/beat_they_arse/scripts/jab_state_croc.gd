extends Node


const STATE_NAME = "jab_state"

@onready var player = $"/root/Global".player
@onready var croc = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine
var player_in_jab_range

func enter():
	print("Hello from jab_state!")
	# Play attack animation
	anim_player.play("Jab1")
	player_in_jab_range = true
	# Set crocodile velocity to punch speed
	

func exit():
	# Go back to the last state
	fsm.back()

func _on_animation_player_animation_finished(anim_name):
	if (fsm.current_state == fsm.states[STATE_NAME]):
		# get player distance
		var distance = player.position - self.global_position
		if (player_in_jab_range and !player.dead):
			# Get next animation
			if (anim_name == "Jab1"):
				# Pick Jab1 or Jab2, weighted
				var num = randf_range(0.0, 1.0)
				if num <= 0.8:
					# play jab2
					anim_player.play("Jab2")
				else:
					# play jab1 again
					anim_player.play("Jab1")
			elif (anim_name == "Jab2"):
				# Play jab1 again
				anim_player.play("Jab1")
		else:
			# Player not in range anymore, exit
			exit()

func _on_jab_range_body_exited(body):
	if (body.name == "Player" and fsm.current_state == fsm.states[STATE_NAME]):
		print("player left punch range in jab state")
		player_in_jab_range = false
	elif (body.name == "Player" and fsm.current_state == fsm.states["hurt_state"]):
		print("Player left punch range in hurt state")
		# Exit right now
		fsm.back()
		player_in_jab_range = false


func _on_punch_area_2d_body_entered(body):
	if (body.name == "Player" and fsm.current_state == fsm.states[STATE_NAME]):
		# Hurt Player here
		print("Hit")
		body.damage(1)
