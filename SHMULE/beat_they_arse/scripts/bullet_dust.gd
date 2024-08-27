extends Marker2D

const bullet_puffs = ["Puff1", "Puff2", "Puff3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play(bullet_puffs.pick_random())

func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
