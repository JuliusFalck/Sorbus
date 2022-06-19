extends Control


#==Variables==#
#=Children=#
onready var listInfo = $PanelContainer/VBoxContainer/Info/ListInfo
onready var icon = $PanelContainer/VBoxContainer/Control/NodeIcon
onready var title = $PanelContainer/VBoxContainer/Title
onready var links = $PanelContainer/VBoxContainer/Links/VBoxContainer/VBoxContainer
onready var bottomButton = $PanelContainer/VBoxContainer/CenterContainer/BottomButton

#=Misc=Vars=#
var node = null setget set_node
var element setget set_element

#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_node(n):
	node = n
	visible = true
	title.text = node.name
	change_icon(node.type, node.icon.c_texture)


func set_element(e):
	element = e
	self.node = Main.map.nodes.get_node(e[0]).get_node(e[1])

#=Getters=#

#=Custom=#
func change_icon(t, c_t):
	icon.type = t
	icon.c_texture = c_t
	
	
	

#=Signals=#


func _on_BottomButton_pressed() -> void:
	Main.view.c_view = Main.map
	Main.map.camera.position == node.rect_position
	Main.map.selected = node


func _on_ActionButton0_pressed() -> void:
	if element != [Main.view.c_element.type, Main.view.c_element.name]:
		Main.view.c_element.dSettingsPanel.show()
