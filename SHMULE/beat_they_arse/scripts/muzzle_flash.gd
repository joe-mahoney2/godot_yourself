extends Marker2D

const flashes = ["Flash1", "Flash2", "Flash3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play(flashes.pick_random())

func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
