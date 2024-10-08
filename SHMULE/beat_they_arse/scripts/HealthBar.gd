extends ProgressBar


@onready var timer = $Timer
@onready var damage_bar = $DamageBar


var health = 0


func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	# animate the decrease
	create_tween().tween_property(damage_bar, "value", value, 0.3)

	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if damage_bar.value <= 0:
		queue_free()


func _on_timer_timeout():
	damage_bar.value = health
