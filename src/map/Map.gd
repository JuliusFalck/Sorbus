extends Control


onready var camera = $MapContainer/MapViewport/Camera
onready var world = $MapContainer/MapViewport/World
onready var links = $MapContainer/MapViewport/World/Links
onready var nodes = $MapContainer/MapViewport/World/Nodes
onready var groups = $MapContainer/MapViewport/World/Groups
onready var nodeTypePicker = $NodeTypePicker
onready var viewport = $MapContainer/MapViewport
onready var moveButton = $MapUI/VBoxContainer/TopBar/MoveButton
onready var addButton = $MapUI/VBoxContainer/TopBar/AddNodeButton
onready var nodeInspector = $MapUI/VBoxContainer/Center/NodeInspector
onready var topBar = $MapUI/VBoxContainer/TopBar
onready var newObjectPopup = $NewObjectPopup

var pan_pos
var is_pan = false

var c_tool = "Select"

var selects = []
var selected = false setget set_selected

var linking = false
var linked_node = null

var c_link = null


func set_selected(s):
	selected = s
	for c in nodes.get_children():
		c.selected = false
	for c in groups.get_children():
		c.selected = false
	if s:
		nodeInspector.node = selected
		
		selected.selected = true
		focus_camera(selected.pos)
	else:
		nodeInspector.visible = false

func _process(delta: float) -> void:
	
	if is_pan:
		pan()
		
	if linking:
		c_link.points[-1] = camera.get_global_mouse_position()
		
#--Camera--#
func pan():
	var delta_mouse = viewport.get_mouse_position() - pan_pos
	pan_pos = viewport.get_mouse_position()
	camera.position -= delta_mouse * camera.zoom[0]

func zoom(value):
	var delta_zoom = camera.get_local_mouse_position() 
	camera.position += delta_zoom * .05 * -value
	camera.zoom *= (Vector2(value, value) * 0.05 + Vector2(1, 1))

func addElement(t, n):
	if t == "Group":
		var new_group = load("res://src/map/Group.tscn").instance()
		new_group.name = n
		new_group.pos = camera.position
		new_group.elements = Global.to_names(selects)
		groups.add_child(new_group)
		return
		
	var new_Node = load("res://src/ui/Nodes/NodeTemplate.tscn").instance()
	new_Node.name = n
	match t:
		"Quiz":
			Global.quizes[new_Node.name] = [Global.default_question.duplicate(true)]
		"Note":
			Global.notes[new_Node.name] = ""
			
	
	nodes.add_child(new_Node)
	new_Node.pos = camera.position
	new_Node.name = n
	new_Node.type = t
	
func add_selected(s):
	selects.append(s)
	self.selected = selects[0]
	for s in selects:
		s.selected = true
		
		
func remove_selected(s):
	selects.erase(s)
	if len(selects) == 0:
		self.selected = null
	else:
		self.selected = selects[0]
		
	for s in selects:
		s.selected = true
		
func focus_camera(pos):
	if !Rect2(camera.position-get_viewport_rect().size*camera.zoom/2.0, get_viewport_rect().size*camera.zoom).has_point(pos):
		
		var dis = camera.position.distance_to(pos)
		var z = dis/min(get_viewport_rect().size.x, get_viewport_rect().size.y)*1.5
		var zoom = camera.zoom
		var time = abs((zoom.x)-z)*2.0
		var tween_zoom_out = Tween.new()
		var tween_pan = Tween.new()
		var tween_zoom_in = Tween.new()
		tween_zoom_out.interpolate_property(camera, "zoom", null, Vector2(z, z), time)
		tween_pan.interpolate_property(camera, "position", null, pos, 2.0 * time)
		tween_zoom_in.interpolate_property(camera, "zoom", Vector2(z, z), zoom, time, 0, 2, time)
		add_child(tween_zoom_out)
		add_child(tween_pan)
		add_child(tween_zoom_in)
		tween_zoom_out.start()
		tween_pan.start()
		tween_zoom_in.start()
		yield(get_tree().create_timer(2.0 * time),"timeout")
		tween_zoom_out.queue_free()
		tween_pan.queue_free()
		tween_zoom_in.queue_free()
	
#=Tools=#

func link(node):
	if !linked_node:
		linked_node = node
		var link = preload("res://src/map/Link.tscn").instance()
		links.add_child(link)
		link.points[0] = node.pos
		c_link = link
		node.links[c_link.name] = 0
		linking = true
	
	else:
		c_link.points[-1] = node.pos
		linking = false
		for i in node.links.keys():
			var inv = Array(links.get_node(i).points)
			inv.invert()
			inv = PoolVector2Array(inv)
			if links.get_node(i).points == c_link.points or inv == c_link.points:
				linked_node.links.erase(c_link.name)
				c_link.queue_free()
				linked_node = null
				return
				
		node.links[c_link.name] = -1
		linked_node.linked_nodes.append(node.name)
		node.linked_nodes.append(linked_node.name)
		linked_node = null
		self.selected = selected
		

#==Signals==#
# Add node
func _on_AddNodeButton_pressed() -> void:
	nodeTypePicker.visible = true
	viewport.gui_disable_input = true

# Pick type
func _on_QuizNodeTypeButton_pressed() -> void:
	newObjectPopup.visible = true
	newObjectPopup.type = "Quiz"
	nodeTypePicker.visible = false
	


func _on_NoteNodeTypeButton_pressed() -> void:
	newObjectPopup.visible = true
	newObjectPopup.type = "Note"
	nodeTypePicker.visible = false



# Tool signals
func _on_MoveButton_pressed() -> void:	
	c_tool = "Move" if c_tool != "Move" else "Select"
	if c_tool == "Move":
		Global.deactivate_children(topBar)


func _on_LinkButton_pressed() -> void:
	c_tool =  "Link" if c_tool != "Link" else "Select"
	if c_tool == "Link":
		Global.deactivate_children(topBar)


# Hide world
func _on_Map_visibility_changed() -> void:
	world.visible = visible


func _on_CloseButton_pressed() -> void:
	addButton.deactivate()
	viewport.gui_disable_input = false


func _on_GroupButton_pressed() -> void:
	newObjectPopup.visible = true
	newObjectPopup.type = "Group"
	
	
	
