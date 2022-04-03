extends Button


#==Variables==#
#=Children=#


#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#


#=Signals=#


func _on_NodeLinkButton_pressed() -> void:
	Main.map.nodes.get_node(text).select(true)
