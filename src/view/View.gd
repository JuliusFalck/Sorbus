extends Control

onready var tabconatainer = $TabContainer
onready var inspector = $ViewInspector

var opened = []

onready var c_element = 0 setget set_view

func set_view(s):
	c_element = s
	if !s is int:
		tabconatainer.current_tab = s.get_index()
		inspector.node = s.node
	else:
		tabconatainer.current_tab = s
		inspector.node = tabconatainer.get_child(s).node
		c_element = tabconatainer.get_child(s)
		
	c_element.refresh()

func open(o):
	Main.c_view = Main.view
	if !tabconatainer.has_node(o.name):
		tabconatainer.add_child(o.make())
		opened.append(o.name)
		set_view(tabconatainer.get_child_count()-1)
		
	else:
		set_view(tabconatainer.get_node(o.name).get_index())


