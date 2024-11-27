extends Node

const STATE_NAME = "Die"

@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fsm: StateMachine

func enter():
	anim_player.play("Fall")
	# disable collision
	vulture.collision_mask &= ~(1 << 0)
	vulture.collision_mask &= ~(1 << 1)
	vulture.collision_layer &= ~(1 << 1)

	vulture.collision_mask |= (1 << 2) # walls

func _physics_process(delta):
	if vulture.is_on_floor():
		vulture.velocity.x = 0
		if not anim_player.current_animation == "Die":
			anim_player.play("Die")
		
	else:
		vulture.velocity.y += delta * gravity

func exit(next_state):
	fsm.change_to(next_state)

func _on_vulture_dead():
	fsm.change_to("Die")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Die":
		vulture.queue_free()
