class_name Body_ctl_t extends CharacterBody2D

var vel
var grounded
var col_mask

func _init():
	vel             = Vector2(0,0)
	grounded        = false
	col_mask        = 0
