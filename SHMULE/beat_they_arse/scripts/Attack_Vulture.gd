extends Node

const STATE_NAME = "Attack"
var targ_pos : Vector2

@onready var player = $"/root/Global".player
@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	print("Caw caw!")
	anim_player.play("Attack")
	# target pos
	targ_pos = player.global_position
	
func _process(delta):
	# Move toward player
	pass
	

func exit(next_state):
	fsm.change_to(next_state)
