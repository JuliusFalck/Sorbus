extends Control

onready var button = $CustomTextureButton
#==Variables==#
#=Children=#


#=Misc=Vars=#
var active = false
#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#


#=Signals=#


func _on_CustomTextureButton_pressed() -> void:
	active = !active
	get_parent().get_child(0).visible = !active
	if active:
		button.texture_normal = preload("res://res/icons/icon_FoldArrowFolded.svg")
		button.texture_disabled = preload("res://res/icons/icon_FoldArrowFolded.svg")
		button.texture_focused = preload("res://res/icons/icon_FoldArrowFolded.svg")
		button.texture_hover = preload("res://res/icons/icon_FoldArrowFolded.svg")
		button.texture_pressed = preload("res://res/icons/icon_FoldArrowFolded.svg")
		
	else:
		button.texture_normal = preload("res://res/icons/icon_FoldArrow.svg")
		button.texture_disabled = preload("res://res/icons/icon_FoldArrow.svg")
		button.texture_focused = preload("res://res/icons/icon_FoldArrow.svg")
		button.texture_hover = preload("res://res/icons/icon_FoldArrow.svg")
		button.texture_pressed = preload("res://res/icons/icon_FoldArrow.svg")
		
		
		
		
		
