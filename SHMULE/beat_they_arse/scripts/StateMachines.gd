extends Node2D


class_name StateMachine

var current_state: Object

var history = []
var states = {}

func _ready():
	# initial state set to first child node
	for state in get_children():
		state.fsm = self
		states[state.name] = state
		if current_state:
			remove_child(state)
		else:
			current_state = state
	current_state.enter()


func change_to(state_name):
	# push current state to memory
	history.append(current_state.name)
	# change to new state
	set_state(state_name)


func back():
	if history.size() > 0:
		set_state(history.pop_back())


func set_state(state_name):
	remove_child(current_state)
	current_state = states[state_name]
	add_child(current_state)
	current_state.enter()
