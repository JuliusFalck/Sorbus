extends Label


#==Variables==#
#=Children=#


#=Misc=Vars=#
var pos setget _set_pos
#==Functions==#


#=Inbuilds=#


#=Setters=#
func _set_pos(p):
	pos = p
	rect_position = p - rect_size*rect_scale/2.0

#=Getters=#

#=Custom=#

#=Signals=#
