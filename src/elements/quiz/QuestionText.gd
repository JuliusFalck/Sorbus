extends Node


#==Variables==#
#=Children=#
onready var textEdit = $TextEdit
onready var textLabel = $Label

#=Misc=Vars=#
var question
var quiz

var text setget set_text
#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_text(t):
	text = t
	textEdit.text = t
	textLabel.text = t

#=Getters=#

#=Custom=#
func edit():
	textEdit.visible = Main.edit
	textLabel.visible = !Main.edit

#=Signals=#


func _on_TextEdit_text_changed() -> void:
	textLabel.text = textEdit.text
	Global.quizes[quiz.name][question][0][get_index()] = textEdit.text
