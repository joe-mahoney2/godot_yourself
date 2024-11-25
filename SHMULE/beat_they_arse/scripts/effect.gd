class_name Effect

extends Marker2D

@export var ANIMATIONS : Array = []
@onready var anim_player = $AnimationPlayer


func _ready():
	if not anim_player:
		push_error("Template class requires an AnimationPlayer node!")
		self.queue_free()
		return
	elif ANIMATIONS.is_empty():
		push_error("No animations specified!")
		self.queue_free()
		return
	else:
		$AnimationPlayer.play(ANIMATIONS.pick_random())

func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
