extends Node


#==Variables==#
#=Children=#
onready var lineEdit = $HBoxContainer/HBoxContainer2/LineEdit
onready var label = $HBoxContainer/HBoxContainer2/Label
onready var dropdownButton = $HBoxContainer/DropdownButton
onready var deletButton = $HBoxContainer/DeleteButton
onready var panel = $Panel
onready var descriptonEdit = $Panel/VBoxContainer/MarginContainer/DescriptionEdit
onready var descriptonLabel = $Panel/VBoxContainer/MarginContainer/DescriptionLabel
onready var IVBox = $Panel/VBoxContainer/ScrollContainer/IVBox


#=Misc=Vars=#
var data = {"title": "", "description": "", "IV": [], "audio": []} setget set_data
var title = "List" setget set_title
var list 

#==Functions==#


#=Inbuilds=#

#=Setters=#


#=Getters=#

#=Custom=#
func edit():
	lineEdit.visible = Main.edit
	label.visible = !Main.edit
	deletButton.visible = Main.edit
	descriptonEdit.visible = Main.edit
	descriptonLabel.visible = !Main.edit
	if (data["description"] != "") or (len(data["IV"]) > 0):
		print("strange")
		dropdownButton.visible = true
		if panel.visible:
			panel.visible = true
			
	else:
		dropdownButton.visible = Main.edit
		panel.visible = false
		
	
func set_title(t):
	title = t
	label.text = t
	lineEdit.text = t

func set_data(d):
	data = d
	Global.lists[list.name]["items"][get_index()] = data
	set_title(data["title"])
	descriptonEdit.text = data["description"]
	descriptonLabel.text = data["description"]
	for c in IVBox.get_children():
		c.queue_free()

	for i in data["IV"]:
		add_res(i)
		
func add_res(r):
	if Global.is_path_image(r) or Global.is_path_video(r):
		var new_IV = preload("res://src/elements/quiz/ImageVideo.tscn").instance()
		new_IV.element = list
		new_IV.sub_element = self
		var c_data = data.duplicate(true)
		c_data["IV"].append(r)
		data = c_data
		IVBox.add_child(new_IV)
		new_IV.set_path(r)
		Global.lists[list.name]["items"][get_index()] = data
		




#=Signals=#


func _on_Button_pressed() -> void:
	Main.view.viewInspector.listInfo.select(data)


func _on_LineEdit_text_changed(new_text: String) -> void:
	title = new_text
	label.text = new_text
	data["title"] = new_text
	Global.lists[list.name]["items"][get_index()] = data


func _on_DeleteButton_pressed() -> void:
	Global.lists[list.name]["items"].erase(get_index())
	queue_free()


func _on_DropdownButton_pressed() -> void:
	panel.visible = !panel.visible
	if panel.visible:
		dropdownButton.texture_normal = preload("res://res/icons/icon_FoldArrowFolded.svg")
		dropdownButton.texture_focused = preload("res://res/icons/icon_FoldArrowFolded.svg")
		dropdownButton.texture_hover = preload("res://res/icons/icon_FoldArrowFolded.svg")
		dropdownButton.texture_pressed = preload("res://res/icons/icon_FoldArrowFolded.svg")
		
		
	else:
		dropdownButton.texture_normal = preload("res://res/icons/icon_FoldArrow.svg")
		dropdownButton.texture_focused = preload("res://res/icons/icon_FoldArrow.svg")
		dropdownButton.texture_hover = preload("res://res/icons/icon_FoldArrow.svg")
		dropdownButton.texture_pressed = preload("res://res/icons/icon_FoldArrow.svg")


func _on_AddButton_pressed() -> void:
	Main.file_function = [self, "add_res"]
	Main.open_res()


func _on_DescriptionEdit_text_changed() -> void:
	data["description"] = descriptonEdit.text
	descriptonLabel.text = descriptonEdit.text
	Global.lists[list.name]["items"][get_index()] = data
