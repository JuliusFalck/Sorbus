extends Control

onready var tabconatainer = $TabContainer

var opened = []

onready var c_view = 0 setget set_view

func set_view(s):
	c_view = s
	if !s is int:
		tabconatainer.current_tab = s.get_index()
	else:
		tabconatainer.current_tab = s

func open(o):
	Main.c_view = Main.view
	if !tabconatainer.has_node(o.name):
		tabconatainer.add_child(o.make())
		opened.append(o.name)
		set_view(tabconatainer.get_child_count()-1)
	else:
		set_view(tabconatainer.get_node(o.name).get_index())


