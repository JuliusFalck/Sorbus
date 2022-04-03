extends MarginContainer

tool
#==Variables==#
#=Children=#
onready var nodeButton = $NodeButton
onready var customTexture = $CustomTexture


var type = "" setget _set_type

var texture = null

var c_texture = null setget _set_c_texture

#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#

#=Setters=#
func _set_type(t):
	type = t
	if nodeButton:
		var texture = load("res://res/icons/icon_" + t + ".svg")
		nodeButton.texture_normal = texture
		if type == "Note" and c_texture:
			texture = load("res://res/icons/icon_empty_Note.svg")
			nodeButton.texture_normal = texture

func _set_c_texture(t):
	c_texture = t
	customTexture.texture = t
	if t:
		var mask = load("res://res/icons/mask_" + type + ".png")
		customTexture.material.set_shader_param("mask", mask)
		self.type = type

#=Getters=#


#=Signals=#
