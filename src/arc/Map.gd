extends Control


onready var camera = $MapContainer/MapViewport/Camera
onready var world = $MapContainer/MapViewport/World
onready var links = $MapContainer/MapViewport/World/Links
onready var nodes = $MapContainer/MapViewport/World/Nodes
onready var nodeTypePicker = $NodeTypePicker
onready var viewport = $MapContainer/MapViewport
onready var moveButton = $MapUI/VBoxContainer/TopBar/MoveButton
onready var addButton = $MapUI/VBoxContainer/TopBar/AddNodeButton
onready var nodeInspector = $MapUI/VBoxContainer/Center/NodeInspector
onready var topBar = $MapUI/VBoxContainer/TopBar

var pan_pos
var is_pan = false

var c_tool = "Select"


var selected_node = false setget set_selected_node

var linking = false
var linked_node = null

var c_link = null


func set_selected_node(s):
	selected_node = s
	for c in nodes.get_children():
		c.selected = false
	if s:
		nodeInspector.node = selected_node
		nodeInspector.visible = true
		nodeInspector.title.text = selected_node.name
		nodeInspector.change_icon(selected_node.type, selected_node.icon.c_texture)
		nodeInspector.set_links()
		selected_node.selected = true
	else:
		nodeInspector.visible = false

func _process(delta: float) -> void:
	
	if is_pan:
		pan()
		
	if linking:
		c_link.points[1] = camera.get_local_mouse_position() / camera.scale + camera.position

#--Camera--#
func pan():
	var delta_mouse = viewport.get_mouse_position() - pan_pos
	pan_pos = viewport.get_mouse_position()
	camera.position -= delta_mouse * camera.zoom[0]

func zoom(value):
	var delta_zoom = camera.get_local_mouse_position() 
	camera.position += delta_zoom * .05 * -value
	camera.zoom *= (Vector2(value, value) * 0.05 + Vector2(1, 1))

func addNode(t):
	var new_Node = load("res://src/ui/Nodes/NodeTemplate.tscn").instance()
	match t:
		"Quiz":
			new_Node.name = t + "_" + str(len(Global.quizes.keys()))
			Global.quizes[new_Node.name] = [Global.default_question.duplicate(true)]
		"Note":
			new_Node.name = t + "_" + str(len(Global.notes.keys()))
			Global.notes[new_Node.name] = ""
			
			
	new_Node.pos = camera.position
	nodes.add_child(new_Node)
	new_Node.type = t
	
	
	
#=Tools=#

func link(node):
	if !linked_node:
		linked_node = node
		var link = preload("res://src/misc/Link.tscn").instance()
		links.add_child(link)
		link.points[0] = node.pos
		c_link = link
		node.links[c_link] = 0
		linking = true
	
	else:
		
		c_link.points[1] = node.pos
		linking = false
		for i in node.links.keys():
			var inv = Array(i.points)
			inv.invert()
			inv = PoolVector2Array(inv)
			if i.points == c_link.points or inv == c_link.points:
				linked_node.links.erase(c_link)
				c_link.queue_free()
				linked_node = null
				return
				
		node.links[c_link] = 1
		linked_node.linked_nodes.append(node)
		node.linked_nodes.append(linked_node)
		linked_node = null
		

#==Signals==#
func _on_AddNodeButton_pressed() -> void:
	nodeTypePicker.visible = !nodeTypePicker.visible

func _on_QuizNodeTypeButton_pressed() -> void:
	addNode("Quiz")
	addButton.deactivate()
	nodeTypePicker.visible = false

func _on_NoteNodeTypeButton_pressed() -> void:
	addNode("Note")
	addButton.deactivate()
	nodeTypePicker.visible = false


func _on_MoveButton_pressed() -> void:	
	c_tool = "Move" if c_tool != "Move" else "Select"
	if c_tool == "Move":
		Global.deactivate_children(topBar)


func _on_LinkButton_pressed() -> void:
	c_tool =  "Link" if c_tool != "Link" else "Select"
	if c_tool == "Link":
		Global.deactivate_children(topBar)

func _on_Map_visibility_changed() -> void:
	world.visible = visible
