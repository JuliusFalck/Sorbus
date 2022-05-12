extends Line2D


#==Variables==#
#=Children=#
onready var background = $Background

#=Misc=Vars=#
var perimiter = [] setget set_perimiter


#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_perimiter(p):
	perimiter = p
	points = p
	background.polygon = p

#=Getters=#

#=Custom=#
func open():
	visible = true
	

#=Signals=#
