extends Control


#==Variables==#
#=Children=#
onready var nodePickBox = $CenterContainer/NodePickBox

#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#


#=Signals=#


func _on_CloseButton_pressed() -> void:
	visible = false


func _on_NodeTypePicker_visibility_changed() -> void:
	for c in nodePickBox.get_children():
		c.modulate = c.std_c


func _on_NoteNodeTypeButton_pressed() -> void:
	Main.map.pick_new_node("Note")


func _on_ListNodeTypeButton_pressed() -> void:
	Main.map.pick_new_node("List")


func _on_QuizNodeTypeButton_pressed() -> void:
	Main.map.pick_new_node("Quiz")


func _on_CardsNodeTypeButton_pressed() -> void:
	Main.map.pick_new_node("Cards")


func _on_FigureNodeTypeButton_pressed() -> void:
	Main.map.pick_new_node("Figure")
