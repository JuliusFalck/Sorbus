extends Node


#==Variables==#
#=Children=#
onready var slideCountLabelIV = $SlideCountLabel
onready var IV = $HBoxImageVideo/ImageVideo

#=Misc=Vars=#
var sub_element
#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#

#=Custom=#

#=Signals=#
func _on_PreviousButtonIV_pressed() -> void:
	sub_element.previous_IV()


func _on_NextButtonIV_pressed() -> void:
	sub_element.next_IV()
