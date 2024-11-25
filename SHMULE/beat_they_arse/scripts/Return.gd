extends Node

const STATE_NAME = "Return"

@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	print("Returning")
	anim_player.play("Fly")

func _physics_process(delta):
	if at_spawn():
		exit("Idle")
	else:
		vulture.head_toward(vulture.spawn_location)

func exit(next_state):
	fsm.change_to(next_state)

func at_spawn() -> bool:
	# distance to spawn
	var dist : Vector2 = self.global_position - vulture.spawn_location
	# If within certain small distance of spawn
	if dist < Vector2(5,5):
		return true
	else:
		return false
