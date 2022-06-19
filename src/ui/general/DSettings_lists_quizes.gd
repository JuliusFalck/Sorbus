extends Node


#==Variables==#
#=Children=#
onready var qAHBox = $VBoxContainer/questionsHBox/questionsAHBox
onready var aAHBox = $VBoxContainer/AnswersHBox/AnswersAHBox
onready var addativeHBox = $VBoxContainer/AddativeHBox/AddativeAHBox

#=Misc=Vars=#

var settings = {"questions": [], "addative": false, "answers": [], "answer_count": 4}


#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_questions():
	settings["questions"] = []
	for c in qAHBox.get_children():
		if c.pressed:
			settings["questions"].append(c.text)
		
func set_addative(a):
	settings["addative"]
	for c in addativeHBox.get_children():
		if c.text == "Yes":
			c.pressed = a
		else:
			c.pressed = !a
	
func set_answers():
	settings["answers"] = []
	for c in aAHBox.get_children():
		if c.pressed:
			settings["answers"].append(c.text)
	
func set_answer_count(c):
	settings["answers_count"] = c
	
	
#=Getters=#

#=Custom=#

#=Signals=#


func _on_QTitlesButton_pressed() -> void:
	set_questions()


func _on_QDescriptionsButton_pressed() -> void:
	set_questions()


func _on_QImagesButton_pressed() -> void:
	set_questions()


func _on_QVideoButton_pressed() -> void:
	set_questions()


func _on_QAudioButton_pressed() -> void:
	set_questions()


func _on_YesButton_pressed() -> void:
	set_addative(true)


func _on_NoButton_pressed() -> void:
	set_addative(false)


func _on_ATitlesButton_pressed() -> void:
	set_answers()


func _on_ADescriptionsButton_pressed() -> void:
	set_answers()


func _on_AImagesButton_pressed() -> void:
	set_answers()


func _on_AVideoButton_pressed() -> void:
	set_answers()


func _on_AAudioButton_pressed() -> void:
	set_answers()


func _on_SpinBox_value_changed(value: float) -> void:
	set_answer_count(value)
