extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Poof")

func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
