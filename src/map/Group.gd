extends Control


#==Variables==#
#=Children=#
onready var shape = $GroupShape
onready var icon = $NodeIcon
onready var title = $TitleLabel

#=Misc=Vars=#
var type = "Group"
var linked_nodes = [] 
var links = {}
var texture_path setget set_texture_path

var res = 216
var speed = 1
var radius = 60
var selected = false setget set_selected
var start_pos = Vector2()
var move = false
var double = false
var pre_select = false


#=Saved=#

var elements = [] setget _set_elements
var perimiter = []
var background_color
var background_texture
var perimiter_width
var perimiter_color
var perimiter_texture
var size = 1 setget _set_size
var pos setget _set_pos

var keywords = []

#==Functions==#


#=Inbuilds=#
func _ready() -> void:
	icon.type = "Group"
	open()

#=Setters=#
func _set_size(s):
	size = s
	radius = s

func _set_pos(p):
	pos = p
	rect_position = p - rect_size/2.0


func set_selected(s):
	selected = s
	if selected:
		icon.nodeButton.modulate = Global.color_palette[1]
	else:
		icon.nodeButton.modulate = Color(1, 1, 1, 1)
	
	
func set_texture_path(t):
	if t:
		texture_path = t
		icon.c_texture = load(t)



func _set_elements(e):
	print("elements")
	elements = e
	for i in elements:
		if !Main.map.nodes.get_node(i).groups.has(name):
			Main.map.nodes.get_node(i).groups.append(name)


#=Getters=#


#=Custom=#

func update_perimiter():
	perimiter = Global.make_group_perimiter(elements, rect_position)
	shape.perimiter = perimiter

func select(s):
	self.selected = s
	if Input.is_action_pressed("Shift"):
		if s:
			Main.map.add_selected(self)
		else:
			Main.map.remove_selected(self)
	else:
		
		if len(Main.map.selects) > 1:
			Main.map.selected = self
			Main.map.selects = [self]
		else:
			Main.map.selected = self if selected else null
			if s:
				Main.map.selects = [self]
			else:
				Main.map.selects = []

func open():
	icon.visible = false
	shape.open()
	var closed_perimiter = []
	update_perimiter()
	for i in range(len(perimiter)):
		closed_perimiter.append(Vector2(cos(TAU/len(perimiter)*i), sin(TAU/len(perimiter)*i))*radius)
		
	shape.perimiter = perimiter
#	for i in range(len(perimiter)):
#		var tween = Tween.new()
#		tween.interpolate_property(shape, "perimiter["+ str(i) +"]", null, perimiter[i], 1/speed, Tween.TRANS_LINEAR)
#
	for i in elements:
		Main.map.nodes.get_node(i).visible = true
	
func close():
	var closed_perimiter = []
	for i in range(res):
		closed_perimiter.append(Vector2(cos(TAU/res*i), sin(TAU/res*i))*radius)
		
	for i in range(res):
		var tween = Tween.new()
		tween.interpolate_property(shape, "perimiter["+ str(i) +"]", null, closed_perimiter, 1/speed, Tween.TRANS_LINEAR)
	for i in elements:
		Main.map.nodes.get_node(i).visible = false

#=Signals=#
func _on_NodeButton_pressed() -> void:
	match Main.map.c_tool:
		"Select":
			if double:
				select(true)
				Main.view.open(self)
				pre_select = false
			else:
				pre_select = selected
				if !pre_select:
					select(!selected)
				double = true
				yield(get_tree().create_timer(0.2),"timeout")
				if pre_select:
					select(!selected)
				double = false
		
		"Link":
			Main.map.link(self)
			
			
		

func _on_NodeButton_button_down() -> void:
	icon.nodeButton.modulate = Global.color_palette[1]
	if Main.map.c_tool == "Move":
		start_pos = get_global_mouse_position()
		move = true

func _on_NodeButton_button_up() -> void:
	if Main.map.c_tool == "Move":
		move = false

func _on_NodeButton_mouse_entered() -> void:
	icon.nodeButton.modulate = Global.color_palette[0]


func _on_NodeButton_mouse_exited() -> void:
	if !selected:
		icon.nodeButton.modulate = Color(1, 1, 1, 1)
	else:
		icon.nodeButton.modulate = Global.color_palette[1]




func _on_Group_renamed() -> void:
	title.text = name
