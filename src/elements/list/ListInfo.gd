extends Node


#==Variables==#
#=Children=#
onready var title = $VBoxContainer/Title
onready var description = $VBoxContainer/ScrollContainer/VBoxContainer/Description

#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#

#=Custom=#

func select(data):
	title.text = data["title"]
	description.text = data["description"]
	

#=Signals=#
