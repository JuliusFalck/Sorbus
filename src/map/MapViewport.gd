extends Viewport




func _input(event: InputEvent) -> void:
	if Main.c_view == Main.map:

	# camera
		# pan
		if event.is_action_pressed("Pan") and Main.map.c_tool != "Move":
			Main.map.pan_pos = mouse()
			Main.map.is_pan = true
		if event.is_action_released("Pan"):
			Main.map.is_pan = false
			
		# zoom in
		if event.is_action_pressed("Zoom_in"):
			Main.map.zoom(-1)
			
		# zoom out
		if event.is_action_pressed("Zoom_out"):
			Main.map.zoom(1)
			
			
			
			
			
func mouse():
	return get_mouse_position()
