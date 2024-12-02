extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var blink_timer = $BlinkTimer
@onready var delete_timer = $DeleteTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("Float")

func _on_area_2d_body_entered(body):
	# Check if it is player (Should always be)
	if (body.name == "Player"):
		body.add_health(1)
		anim_player.play("Consumed")

func _on_blink_timer_timeout():
		# start blinking animation
	anim_player.play("Blink")
	delete_timer.wait_time = 5.0
	delete_timer.start()

func _on_delete_timer_timeout():
	self.queue_free()

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Consumed"):
		self.queue_free()
