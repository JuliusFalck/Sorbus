extends HBoxContainer

onready var TextEdit = $TextEdit
onready var correctButton = $CorrectButton

var quiz = ""
var question = 0
var answer = 0

var text setget _set_text

var correct = false setget set_correct

var style = StyleBoxFlat.new()



func set_correct(c):
	correct = c
	Global.quizes[quiz][question][1][answer][0] = c
	style.bg_color = Color(0, 1, 0, .5) if correct else  Color(1, 0, 0, .5)
	correctButton.add_stylebox_override("normal", style)
	correctButton.add_stylebox_override("hover", style)
	correctButton.release_focus()

func _set_text(t):
	text = t
	TextEdit.text = t
	Global.quizes[quiz][question][1][answer][1] = t
	


func _on_DeleteButton_pressed() -> void:
	Global.quizes[quiz][question][1].remove(answer)
	queue_free()


func _on_CorrectButton_pressed() -> void:
	self.correct = !correct
	


func _on_TextEdit_text_changed(new_text: String) -> void:
	Global.quizes[quiz][question][1][answer][1] = new_text
