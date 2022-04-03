extends Node


#==Variables==#
#=Children=#


#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#


#=Signals=#


func _on_OpenButton_pressed() -> void:
	Main.view.open(Main.map.selected_node)
