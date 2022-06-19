extends Node


#==Variables==#
#=Children=#
onready var audioPlayer = $AudioStreamPlayer
onready var playButton = $PlayAudioButton
onready var pickAudioButton = $PickAudioButton 

#=Misc=Vars=#
var question
var quiz

var path setget set_path
#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_path(a):
	if a:
		path = a
		audioPlayer.stream = load(path)

#=Getters=#

#=Custom=#
func edit():
	pickAudioButton.visible = Main.edit
	playButton.visible = !Main.edit
	
#=Signals=#
