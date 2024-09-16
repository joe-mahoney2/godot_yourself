extends Node

# Player data
var player
const PLAYER_JUMP_VELOCITY = -400 # currently unused becasue i am lazy 
const MAX_HEALTH_PLAYER = 10

# Mob data
const MOB_SPEED = 150
const MOB_JAB_SPEED = 20
const MOB_JUMP_VELOCITY = -200

func _ready():
	pass

func register_player(in_player):
	player = in_player

