extends Node2D


var speed = 2500

var bullet_dust = preload("res://scenes/effects/bullet_dust.tscn")

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	# If it is an enemy, damage
	if body.is_in_group("Enemy"):
		body.damage(1)
	# If it is the ground, spawn dust
	else:
		spawn_bullet_dust()
	# Free self
	self.queue_free()

func spawn_bullet_dust():
	var bull_dust = bullet_dust.instantiate()
	bull_dust.global_position = global_position
	get_parent().get_parent().add_child(bull_dust)
