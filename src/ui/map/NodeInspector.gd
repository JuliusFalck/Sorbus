extends Node


#==Variables==#
#=Children=#
onready var icon = $PanelContainer/VBoxContainer/Control/NodeIcon
onready var title = $PanelContainer/VBoxContainer/Title
onready var links = $PanelContainer/VBoxContainer/Links/VBoxContainer/VBoxContainer

#=Misc=Vars=#
var node = null

#==Functions==#
#=Inbuilds=#
#=Setters=#
#=Getters=#
#=Custom=#
func change_icon(t, c_t):
	icon.type = t
	icon.c_texture = c_t
	


func change_custom_icon(t):
	icon.c_texture = load(t)
	node.icon.c_texture = load(t)
	


func set_links():
	for c in links.get_children():
		c.queue_free()
	
	for l in node.linked_nodes:
		var link_button = preload("res://src/ui/map/NodeLinkButton.tscn").instance()
		link_button.text = l.name
		links.add_child(link_button)
	
	
#=Signals=#


func _on_Icon_mouse_entered() -> void:
	icon.modulate = Color(1, 1, 1, 0.8)


func _on_Icon_mouse_exited() -> void:
	icon.modulate = Color(1, 1, 1, 1)


func _on_Title_focus_exited() -> void:
	Global.rename(Main.map.selected_node.name, title.text)
	Main.map.selected_node.name = title.text


func _on_Icon_pressed() -> void:
	Main.file_function = [self, "change_custom_icon"]
	Main.open_res()




