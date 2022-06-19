extends Control

tool 
#==Variables==#
#=Children=#
onready var icon = $PanelContainer/VBoxContainer/Control/NodeIcon
onready var title = $PanelContainer/VBoxContainer/Title
onready var links = $PanelContainer/VBoxContainer/Links/VBoxContainer/VBoxContainer
onready var bottomButton = $PanelContainer/VBoxContainer/CenterContainer/BottomButton


#=Misc=Vars=#


var node = null setget set_node

#==Functions==#
#=Inbuilds=#

#=Setters=#
#=Getters=#
#=Custom=#
func change_icon(t, c_t):
	icon.type = t
	icon.c_texture = c_t
	
func change_custom_icon(t):
	node.texture_path = t
	icon.c_texture = load(t)
	Global.get_(node.type)[node.name]["icon"] = t

func set_node(n):
	node = n
	visible = true
	title.text = node.name
	change_icon(node.type, node.icon.c_texture)
	set_links()


func set_links():
	for c in links.get_children():
		c.queue_free()
	
	for l in node.linked_nodes:
		var link_button = preload("res://src/ui/map/NodeLinkButton.tscn").instance()
		link_button.text = l
		links.add_child(link_button)
	
	
#=Signals=#


func _on_Icon_mouse_entered() -> void:
	icon.modulate = Color(1, 1, 1, 0.8)


func _on_Icon_mouse_exited() -> void:
	icon.modulate = Color(1, 1, 1, 1)


func _on_Title_focus_exited() -> void:
	Global.rename(Main.map.selected.name, title.text)
	Main.map.selected.name = title.text


func _on_Icon_pressed() -> void:
	Main.file_function = [self, "change_custom_icon"]
	Main.open_res()






func _on_BottomButton_pressed() -> void:

		Main.view.open(Main.map.selected)
	
		
		
