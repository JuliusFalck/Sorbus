extends Node


#==Variables==#
#=Children=#
onready var videoPlayer = $VideoPlayer
onready var pickVideoButton = $PickVideoButton

#=Misc=Vars=#
var question
var quiz

var video setget set_video
#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_video(v):
	if v:
		video = v
		videoPlayer.stream = load(video)

#=Getters=#

#=Custom=#
func edit():
	pickVideoButton.visible = Main.edit
	videoPlayer.visible = !Main.edit
	
#=Signals=#
