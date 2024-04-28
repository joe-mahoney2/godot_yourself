extends Node

var flavorText = {}
var numFlavors : int
var dataFilePath = "res://data/flavorText.json"
var fallBack = { "flavor_en": ["Better with Milk!", "Now, this is epic!", "Stupid Science bitch!"]}

func _ready():
	flavorText = loadJson(dataFilePath)

func loadJson(filePath : String):
	if (FileAccess.file_exists(filePath)):
		var file = FileAccess.open(filePath, FileAccess.READ)
		var parsed = JSON.parse_string(file.get_as_text())
		numFlavors = parsed.flavors_en.size()
		
		if (parsed is Dictionary):
			return parsed
		# Something went wrong use default
		else:
			return  fallBack
	# Couldn't find flavorText file use default
	else:
		return fallBack
