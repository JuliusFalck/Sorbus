extends Node


#==Variables==#
#=Children=#
onready var viewport = $ViewportContainer/Viewport
onready var camera = $ViewportContainer/Viewport/Camera

#=Misc=Vars=#
var pan_pos
var is_pan = false
var node = null

#==Functions==#


#=Inbuilds=#
func _process(delta: float) -> void:
	
	if is_pan:
		pan()
		

#=Setters=#


#=Getters=#

#=Custom=#


		
#--Camera--#
func pan():
	var delta_mouse = viewport.get_mouse_position() - pan_pos
	pan_pos = viewport.get_mouse_position()
	camera.position -= delta_mouse * camera.zoom[0]

func zoom(value):
	var delta_zoom = camera.get_local_mouse_position() 
	camera.position += delta_zoom * .05 * -value
	camera.zoom *= (Vector2(value, value) * 0.05 + Vector2(1, 1))


#=Signals=#
