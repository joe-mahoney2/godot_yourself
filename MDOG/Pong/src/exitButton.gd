extends Button
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/10/2024                ##
##                                               ##
## This script simply closes the application on  ##
## exit button pressed.                          ##
##                                               ##
## TODO: Make the code header less stupid :P     ##
## --------------------------------------------- ##


func _on_pressed():
	# get_tree() gives access to the global SceneTree
	# object so we can control scenes and exit the game
	get_tree().quit() 
