extends ParallaxBackground

var scrollSpeed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_base_offset.x -= delta * scrollSpeed
