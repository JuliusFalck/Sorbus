extends CenterContainer

class_name CustomTextEdit

onready var textDisplay = $TextDisplay
onready var textEdit = $TextEdit

var align = "[center]"


func set_text(t):
	var text = align + t
	text = text.replace("\n", align+"\n")
	textDisplay.bbcode_text = text
	



func _on_TextEdit_text_changed() -> void:
	set_text(textEdit.text)
