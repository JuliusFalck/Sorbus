extends MarginContainer
tool
onready var icon = $VBoxContainer/NodeIcon
onready var title = $VBoxContainer/TitleLabel
onready var button = $Button


#=Saved=#

export (String, "Note", "List", "Quiz", "Cards", "Image", "Chart") var type setget _set_type

var pos = Vector2(0, 0) setget _set_pos

var size = 1 setget _set_size
var linked_nodes = [] 

var links = {}

var texture_path setget set_texture_path

var groups = []


#=Not=Saved=#
var selected = false setget set_selected
var start_pos = Vector2()
var move = false
var double = false
var pre_select = false






#==Functions==#

#=Inbuilds=#
func _ready() -> void:
	self.size = size

func _process(delta: float) -> void:
	if move:
		var d = get_global_mouse_position() - start_pos
		self.pos += d
		for i in groups:
			Main.map.groups.get_node(i).update_perimiter()
		for l in links.keys():
			var link = Main.map.links.get_node(l)
			link.points[links[l]] = link.points[links[l]] + d
		start_pos = get_global_mouse_position()


#=Setters=#
func _set_type(t):
	type = t
	if icon:
		icon.type = t
	
func _set_size(s):
	size = s
	rect_scale = Vector2(s, s)
	self.pos = pos



func _set_pos(p):
	pos = Vector2(p[0], p[1])
	rect_position = pos - icon.rect_size*rect_scale/2
	
	
func set_selected(s):
	selected = s
	if button.get_global_rect().has_point(get_global_mouse_position()):
			icon.nodeButton.modulate = Global.color_palette[0]
			title.modulate = Global.color_palette[0]
	else:
		if selected:
			icon.nodeButton.modulate = Global.color_palette[1]
			title.modulate = Global.color_palette[1]
		else:
			icon.nodeButton.modulate = Color(1, 1, 1, 1)
			title.modulate = Color(1, 1, 1, 1)

func set_texture_path(t):
	if t:
		texture_path = t
		icon.c_texture = load(t)
	


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

#=Getters=#

#=Custom=#

func make():
	var res = load("res://src/elements/" + type.to_lower() + "/" + type + ".tscn").instance()
	res.name = name
	res.node = self
	return res
	
	
func save():
	var save_dict = {
		"name": name,
		"filename": filename,
		"parent": get_parent().get_path(),
		"type": type,
		"size": size,
		"linked_nodes": linked_nodes,
		"links": links,
		"pos": [pos.x, pos.y],
		"texture_path": texture_path,
	}
	
	return save_dict
	
#=Signals=#
func _on_Button_pressed() -> void:
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
			
			
		

func _on_Button_button_down() -> void:
	icon.nodeButton.modulate = Global.color_palette[1]
	title.modulate = Global.color_palette[1]
	if Main.map.c_tool == "Move":
		start_pos = get_global_mouse_position()
		move = true

func _on_Button_button_up() -> void:
	if Main.map.c_tool == "Move":
		move = false


func _on_Button_mouse_entered() -> void:
	icon.nodeButton.modulate = Global.color_palette[0]
	title.modulate = Global.color_palette[0]


func _on_Button_mouse_exited() -> void:
	if !selected:
		icon.nodeButton.modulate = Color(1, 1, 1, 1)
		title.modulate = Color(1, 1, 1, 1)
	else:
		icon.nodeButton.modulate = Global.color_palette[1]
		title.modulate = Global.color_palette[1]


func _on_NodeTemplate_renamed() -> void:
	title.text = name


