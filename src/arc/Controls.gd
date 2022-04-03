extends Node

var mouse_on = null setget ,_get_mouse_on



func _get_mouse_on():
	if Main.c_view.get_global_rect().has_point(mouse()):
		return Main.c_view




	




func mouse():
	return get_tree().get_root().get_mouse_position()
