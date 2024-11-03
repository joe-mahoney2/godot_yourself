extends Node

const STATE_NAME = "death_state"

@onready var croc = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	print("Dying")
	croc.velocity.x = 0
	# Play death animation
	anim_player.play("Death")
	# Disable collision with player and other enemies
	croc.collision_mask &= ~(1 << 0)
	croc.collision_mask &= ~(1 << 1)
	croc.collision_layer  &= ~(1 << 1)

func exit(next_state):
	fsm.change_to(next_state)
	
func _process(_delta):
	pass

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Death"):
		croc.queue_free()

func _on_crocodile_goon_dead():
	fsm.change_to("death_state")
