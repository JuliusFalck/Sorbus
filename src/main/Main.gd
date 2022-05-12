extends Control




onready var mainView = $VBoxContainer/MainView
onready var view = mainView.get_node("View")
onready var map = mainView.get_node("Map")
onready var list = mainView.get_node("List")
onready var fileDialog = $FileDialog

var file_function = [null, ""]

var selected_file_path = null

onready var c_view = view setget set_view

func set_view(s):
	c_view = s
	mainView.current_tab = s.get_index()

func open_res():
	fileDialog.visible = true


func _on_MainView_tab_changed(tab: int) -> void:
	self.c_view = mainView.get_child(tab)


func _on_FileDialog_file_selected(path: String) -> void:
	file_function[0].call(file_function[1], path)
	


