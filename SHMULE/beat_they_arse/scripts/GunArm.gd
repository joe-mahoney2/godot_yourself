extends Node2D

@onready var character_body: CharacterBody2D = get_parent()
@onready var image: Sprite2D = $Image
@onready var tip: Marker2D = $GunTip
@onready var ray: RayCast2D = $RayCast2D

var muzzle_flash = preload("res://scenes/effects/muzzle_flash.tscn")
var bullet_projectile = preload("res://scenes/effects/bullet_projectile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character_body.dead:
		return
	
	if Input.is_action_just_pressed("left_click"):
		shoot()
	
func spawn_flash():
	var flash = muzzle_flash.instantiate()
	flash.position = tip.position
	self.add_child(flash)

#TODO: FIX THIS FUNCTION
func spawn_trail():
	# Create a new instance of the fading node
	var line = Line2D.new()
	line.width = 2
	line.add_point(tip.position)
	var line_end = get_global_mouse_position()
	line.add_point(line_end)
	line.default_color = Color.GRAY
	line.width = 2
	add_child(line)
	# start fade
	var tween = create_tween()
	
	tween.tween_property(line, "modulate:a", 0, 1.0)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	
	await tween.finished
	line.queue_free()

func shoot():
	# spawn muzzle flare
	spawn_flash()
	# player knockback (remove for now)
	# character_body.velocity -= direction * 200
	
	# spawn bullet
	var bullet = bullet_projectile.instantiate()
	# set bullet position
	bullet.global_position = tip.global_position
	bullet.rotation = rotation
	# add to scene
	get_parent().add_child(bullet)
	
