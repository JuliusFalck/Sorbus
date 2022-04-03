extends TextureButton

class_name CustomTextureButton
tool

export var toggle = true
export (String, "Green", "Red", "Blue") var c_color


var std_c = Color(.95, .95, .95, 1)
var colors = {"Green": [Color(0, .8, 0, 1), Color(0, .67, 0, 1)],
"Red": [Color(0.8, 0, 0, 1), Color(.67, 0, 0, 1)],
"Blue": [Color(0, 0, .8, 1), Color(0, 0, 0.67, 1)],}

var active = false

#==Variables==#
#=Children=#


#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#
func _ready() -> void:
	modulate = std_c

#=Setters=#


#=Getters=#


#=Custom=#
func activate():
	active = true
	modulate = colors[c_color][1]
	
func deactivate():
	active = false
	modulate = std_c


#=Signals=#


func _on_TextureButton_mouse_entered() -> void:
	modulate = colors[c_color][0]


func _on_TextureButton_mouse_exited() -> void:
	if !active:
		modulate = std_c


func _on_TextureButton_button_down() -> void:
	modulate = colors[c_color][1]


func _on_TextureButton_button_up() -> void:
	if toggle:
		active = !active
		modulate = colors[c_color][1]
	else:
		modulate = colors[c_color][0]


func _on_CustomTextureButton_visibility_changed() -> void:
	modulate = std_c
