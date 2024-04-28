extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var randInt = randi() % FlavorText.numFlavors
	$".".text =  "[pulse freq=1.0 color=#ffffff40 ease=-2.0]"  \
	+ FlavorText.flavorText.flavors_en[randInt] + "[/pulse]"
