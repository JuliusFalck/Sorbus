extends Control


#==Variables==#
#=Children=#
onready var textEdit = $CenterContainer/TextEdit

#=Misc=Vars=#
var node = null

#==Functions==#
#=Inbuilds=#
func _ready() -> void:
	textEdit.text = Global.notes[name]

#=Setters=#


#=Getters=#


#=Signals=#
func _on_TextEdit_text_changed() -> void:
	Global.notes[name] = textEdit.text
	if node:
		node.size = 1 + log(1 +len(textEdit.text)/900.0)/9.0
