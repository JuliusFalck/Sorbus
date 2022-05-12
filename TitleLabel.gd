extends Label


#==Variables==#
#=Children=#


#=Misc=Vars=#
var pos setget _set_pos
#==Functions==#


#=Inbuilds=#
func _ready() -> void:
	yield(get_tree(), "idle_frame")
	rect_scale = Vector2(0.3, 0.3)
	self.pos =  Vector2(get_parent().rect_size.x/2, rect_position.y*0.9)

#=Setters=#
func _set_pos(p):
	pos = p
	rect_position = p - rect_size*rect_scale/2.0

#=Getters=#

#=Custom=#

#=Signals=#
