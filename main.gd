extends Control

# Preload the key scene
const KeyScene = preload("res://key.tscn")

# Notes in order, matching your .wav filenames exactly
var notes = ["C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5"]

# Colours for each key (white piano keys — you can customise these)
var key_colors = [
	Color(1, 1, 1),       # C - white
	Color(1, 1, 1),       # D - white
	Color(1, 1, 1),       # E - white
	Color(1, 1, 1),       # F - white
	Color(1, 1, 1),       # G - white
	Color(1, 1, 1),       # A - white
	Color(1, 1, 1),       # B - white
	Color(1, 1, 1),       # C5 - white
]

func _ready():
	_build_piano()

func _build_piano():
	var hbox = $HBoxContainer

	for i in range(notes.size()):
		# Create a new key from the scene
		var key = KeyScene.instantiate()
		hbox.add_child(key)

		# Set its size
		key.custom_minimum_size = Vector2(90, 200)

		# Pass in the note name and colour
		key.setup(notes[i], key_colors[i])
