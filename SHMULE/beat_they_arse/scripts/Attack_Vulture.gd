extends Node

const STATE_NAME = "Attack"

var attack_pos : Vector2
var end_pos : Vector2

@onready var player = $"/root/Global".player
@onready var vulture = get_parent().get_parent()
@onready var anim_player = $"../../AnimationPlayer"
@onready var body_collision = $"../../CollisionShape2D"

var fsm: StateMachine

func enter():
	print("Caw caw!")
	anim_player.play("Attack")
	# i am just going to disable all collision
	body_collision.disabled = true
	
	# target pos
	attack_pos = player.global_position
	var x_distance = attack_pos.x - vulture.global_position.x
	
	end_pos = vulture.global_position
	end_pos.x += 2 * x_distance
	# Handle edge cases
	end_pos.x = max(end_pos.x, 0)
	end_pos.y = attack_pos.y - (randi() % 151 + 50)

	
func _process(delta):
	# if we are close to target, go to end pos
	var distance = vulture.global_position - attack_pos
	if (distance.length() < 10):
		if (attack_pos == end_pos):
			# we are finished attacking
			exit()
		else:
			attack_pos = end_pos
	# Move toward player position and enable hit box
	vulture.head_straight_to(attack_pos)
	

func exit():
	body_collision.disabled = false
	fsm.back()

func _on_node_body_entered(body):
	if (body.name == "Player" and fsm.current_state == fsm.states[STATE_NAME]):
		body.damage(1)
