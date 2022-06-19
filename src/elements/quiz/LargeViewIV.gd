extends Node


#==Variables==#
#=Children=#
onready var fade = $Fade
onready var control = $Control

#=Misc=Vars=#
var sub_element
var visible = false setget set_visible

#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_visible(v):
	visible = v
	for c in get_children():
		c.visible = v

#=Getters=#

#=Custom=#

#=Signals=#


func _on_ExitButton_pressed() -> void:
	sub_element.exit_large_view()
