extends ParallaxBackground
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/10/2024                ##
##                                               ##
## This script handles the parallax background   ##
## scrolling on the title screen.                ##
##                                               ##
## --------------------------------------------- ##
var scrollSpeed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_base_offset.x -= delta * scrollSpeed
