extends MarginContainer

tool
onready var icon = $NodeIcon
onready var setlectRing = $SelectRing



export (String, "Note", "Quiz", "Image", "Chart") var type setget _set_type


var start_pos = Vector2()
var move = false
var size = 1 setget _set_size
var selected = false setget set_selected

var double = false
var pre_select = false

var linked_nodes = []

var links = {}

var pos = Vector2(0, 0) setget _set_pos

func _set_type(t):
	type = t
	if icon:
		icon.type = t
	
func _set_size(s):
	size = s
	rect_scale = Vector2(s, s)
	self.pos = pos

func _process(delta: float) -> void:
	if move:
		var d = get_global_mouse_position() - start_pos
		rect_position += d
		for l in links:
			l[0].points[l[1]] += d
		start_pos = get_global_mouse_position()

func _set_pos(p):
	pos = p
	rect_position = pos - rect_size*rect_scale/2
	
	
func set_selected(s):
	selected = s
	if selected:
		setlectRing.visible = true
		setlectRing.modulate.a = 1
	else:
		setlectRing.visible = false
		
func select(s):
	self.selected = s
	Main.map.selected_node = self if selected else null

func make():
	var res = load("res://src/ui/" + type.to_lower() + "/" + type + ".tscn").instance()
	res.name = name
	res.node = self
	return res

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
	if Main.map.c_tool == "Move":
		start_pos = get_global_mouse_position()
		move = true

func _on_NodeButton_button_up() -> void:
	if Main.map.c_tool == "Move":
		move = false


func _on_NodeButton_mouse_entered() -> void:
	if !selected:
		setlectRing.visible = true
		setlectRing.modulate.a = 0.5


func _on_NodeButton_mouse_exited() -> void:
	if !selected:
		setlectRing.visible = false
