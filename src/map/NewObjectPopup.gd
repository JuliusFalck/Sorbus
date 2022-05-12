extends PanelContainer


#==Variables==#
#=Children=#
onready var label = $MarginContainer/VBoxContainer/Label

#=Misc=Vars=#
var text
var type setget set_type

#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_type(t):
	type = t
	label.text =  "New " + t + " named:"
	

#=Getters=#


#=Signals=#


func _on_AddButton_pressed() -> void:
	Main.map.addElement(type, text)
	Main.map.addButton.deactivate()
	Main.map.viewport.gui_disable_input = false
	visible = false
	

func _on_CancelButton_pressed() -> void:
	Main.map.addButton.deactivate()
	Main.map.viewport.gui_disable_input = false
	visible = false


func _on_LineEdit_text_changed(new_text: String) -> void:
	text = new_text
