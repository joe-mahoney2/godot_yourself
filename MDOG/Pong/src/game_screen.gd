extends Node
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/11/2024                ##
##                                               ##
## This script handles when the ball collides    ##
## with the area2d node, leftGoal, when it does  ##
## we reset the ball location and add to the     ##
## opponent's score.                             ##
##                                               ##
## --------------------------------------------- ##
@export var screenSizeX = 1280
@export var screenSizeY = 720

# Opposition scores
func _on_left_goal_body_entered(body):
	$ball.position = Vector2(screenSizeX / 2, screenSizeY / 2)

# Player scores
func _on_right_goal_body_entered(body):
	$ball.position = Vector2(screenSizeX / 2, screenSizeY / 2)
