extends Node

const STATE_NAME = "Idle"

const IDLE_ANIMATIONS = ["Idle", "Idle2", "Idle3"]

var look_for : int = 0
var curr_anim : String

@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"

var fsm: StateMachine

func enter():
	print("Vulture idling!")
	# If at spawn
	chill()

func exit(next_state):
	fsm.change_to(next_state)

func _physics_process(delta):
	# if we are not hanging at spawn
	vulture.velocity = Vector2(0,0)

func _on_animation_player_animation_finished(anim_name):
	if (anim_name in IDLE_ANIMATIONS):
		# Decrement look_for
		look_for -= 1
	if (look_for == 0):
		look_for = randi() % 4 + 2
		curr_anim = IDLE_ANIMATIONS.pick_random()
		if (curr_anim == "Idle3"):
			look_for = 1
	anim_player.play(curr_anim)


func _on_player_detection_body_entered(body):
	if (body.name == "Player" and (fsm.current_state == fsm.states[STATE_NAME] or
		fsm.current_state == fsm.states["Return"])):
		# Chase the player
		exit("Chase")

func return_to_spawn():
	anim_player.play("Fly")
	# Calculate direction to spawn and fly there
	vulture.head_toward(vulture.spawn_location)
	
func chill():
	# Set look for to random int 1-4
	look_for = randi() % 4 + 1
	curr_anim = IDLE_ANIMATIONS.pick_random()
	if (curr_anim == "Idle3"):
		look_for = 1
	anim_player.play(curr_anim)

