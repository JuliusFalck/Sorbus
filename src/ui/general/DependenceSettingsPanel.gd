extends Control


#==Variables==#
#=Children=#
onready var panel = $PanelContainer

#=Misc=Vars=#
var t_element
var g_element 

var settings


#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#

#=Custom=#
func show():
	for c in panel.get_children():
		c.queue_free()
	t_element = Main.view.c_element
	g_element = Main.view.inspector.element
	settings = load("res://src/ui/general/DSettings_" + g_element[0] + "_" + t_element.type + ".tscn").instance()
	visible = true
	panel.add_child(settings)


func generate():
	Main.view.c_element.givers[[g_element[0], g_element[1]]] = settings.settings
	Main.view.c_element.generate()
	visible = false
	
	
#=Signals=#


func _on_GenerateButton_pressed() -> void:
	generate()
