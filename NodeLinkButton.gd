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
	if Main.c_view == Main.map:
		Main.map.nodes.get_node(text).select(true)
	elif Main.c_view == Main.view:
		Main.view.open(Main.map.nodes.get_node(text))
