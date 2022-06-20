extends Control




onready var mainView = $VBoxContainer/MainView
onready var view = mainView.get_node("View")
onready var map = mainView.get_node("Map")
onready var tasks = mainView.get_node("Tasks")
onready var fileDialog = $FileDialog

var file_function = [null, ""]

var selected_file_path = null

var edit = true setget set_edit

onready var c_view = view setget set_view

var c_inspector

func set_view(s):
	c_view = s
	mainView.current_tab = s.get_index()
	c_inspector = c_view.inspector

func open_res():
	fileDialog.visible = true


func _on_MainView_tab_changed(tab: int) -> void:
	self.c_view = mainView.get_child(tab)


func _on_FileDialog_file_selected(path: String) -> void:
	file_function[0].call(file_function[1], path)
	
func _on_FileDialog_dir_selected(dir: String) -> void:
	file_function[0].call(file_function[1], dir)

func _on_Button_pressed() -> void:
	self.edit = !edit


func set_edit(e):
	edit = e
	for c in view.tabconatainer.get_children():
		c.edit()
	map.edit()



