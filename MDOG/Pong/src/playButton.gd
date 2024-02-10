extends Button
## --------------------------------------------- ##
## Original Developer : Mason McDaniel           ##
## Copyright          : Mason McDaniel 2024      ##
## Created            : 2/10/2024                ##
##                                               ##
## This script handles the playButton pressed    ##
## signal and opens the gameBoard scene to       ##
## run the game from                             ##
##                                               ##
## TODO: Make the code header less stupid :P     ##
## --------------------------------------------- ##


func _on_pressed():
	# The player pressed the play button so switch to the gameBoard
	# scene and start the game
	get_tree().change_scene_to_file("res://src/gameBoard.tscn")
