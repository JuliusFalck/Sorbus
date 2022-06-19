extends Node


#==Variables==#
#=Children=#
onready var icon = $HBoxContainer/TextureRect
onready var label = $HBoxContainer/Label
onready var button = $TextureButton
onready var highlight = $ColorRect


var type 

#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#

#=Custom=#
func select():
	for c in get_parent().get_children():
		c.deselect()
	label.modulate = Global.colors["Green"][0]
	Main.c_inspector.element = [type, label.text]

func deselect():
	label.modulate = Color.white
	
	
	
#=Signals=#


func _on_TextureButton_pressed() -> void:
	select()


func _on_TextureButton_mouse_entered() -> void:
	highlight.color = Color(0, 1, 0, 0.2)


func _on_TextureButton_mouse_exited() -> void:
	highlight.color = Color(1, 1, 1, 0.0)
