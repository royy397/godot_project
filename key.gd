extends Panel

# These will be set by main.gd when the key is created
var note_name: String = ""
var color_normal: Color = Color(1, 1, 1)      # white
var color_pressed: Color = Color(0.7, 0.85, 1) # light blue when pressed

func setup(p_note_name: String, p_color: Color):
	note_name = p_note_name
	color_normal = p_color
	color_pressed = p_color.darkened(0.3)

	# Set the label text to the note name
	$Label.text = note_name
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	$Label.anchors_preset = Control.PRESET_FULL_RECT

	# Load the sound file for this note
	var stream = load("res://sounds/" + note_name + ".wav")
	$AudioStreamPlayer.stream = stream

	# Set background colour
	add_theme_stylebox_override("panel", _make_stylebox(color_normal))

func _make_stylebox(col: Color) -> StyleBoxFlat:
	var sb = StyleBoxFlat.new()
	sb.bg_color = col
	sb.border_width_left = 2
	sb.border_width_right = 2
	sb.border_width_top = 2
	sb.border_width_bottom = 2
	sb.border_color = Color(0, 0, 0)  # black border
	sb.corner_radius_bottom_left = 6
	sb.corner_radius_bottom_right = 6
	return sb

func _gui_input(event: InputEvent):
	# Detect mouse/touch press and release
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_on_pressed()
		else:
			_on_released()

func _on_pressed():
	$AudioStreamPlayer.play()
	var random_color = Color.from_hsv(randf(), 0.8, 1.0)
	add_theme_stylebox_override("panel", _make_stylebox(random_color))
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.95, 0.95), 0.05)
	print(note_name)

func _on_released():
	add_theme_stylebox_override("panel", _make_stylebox(color_normal))
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
