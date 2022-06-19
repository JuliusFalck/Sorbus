extends Button


var correct = true
var style = StyleBoxFlat.new()

var active = false


func _on_QuizButton_pressed() -> void:
	active = !active
	if active:
		style.bg_color = Color(0, 1, 0, .5) if correct else  Color(1, 0, 0, .5)
	else:
		style.bg_color = Color(0.16, 0.16, 0.16, 1)
	add_stylebox_override("normal", style)
	add_stylebox_override("hover", style)
	
	release_focus()
