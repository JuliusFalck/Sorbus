extends Control

onready var listBox = $MarginContainer/VBoxContainer/ScrollContainer/ListBox
onready var titleLabel = $MarginContainer/VBoxContainer/TitleLabel
onready var addButton = $MarginContainer/VBoxContainer/AddButton
onready var titleEdit = $MarginContainer/VBoxContainer/TitleEdit


var givers = {}
var takers = {}


var title = "List" setget set_title

var node = null

var type = "lists"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.title = Main.map.selected.name
	for l in range(len(Global.lists[name]["items"])):
		var listItem = preload("res://src/elements/list/ListItem.tscn").instance()
		listItem.list = self
		listBox.add_child(listItem)
		listItem.data = Global.lists[name]["items"][l]
	
	



func edit():
	addButton.visible = Main.edit
	
	for i in listBox.get_children():
		i.edit()

func refresh():
	pass

func set_title(t):
	title = t
	titleLabel.text = t
	titleEdit.text = t


func _on_AddButton_pressed() -> void:
	Global.lists[name]["items"].append(Global.default_list_item.duplicate(true))
	var new_list_item = preload("res://src/elements/list/ListItem.tscn").instance()
	new_list_item.list = self
	listBox.add_child(new_list_item)
	node.size = 1 + log(len(Global.lists[name]))/9.0



func _on_TitleEdit_text_entered(new_text: String) -> void:
	self.title = new_text
