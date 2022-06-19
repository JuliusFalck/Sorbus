extends MarginContainer


#==Variables==#
#=Children=#
onready var button = $MarginContainer/Button
onready var imageTexture = $MarginContainer/Image
onready var videoPlayer = $MarginContainer/VideoPlayer
onready var frame = $Control/Frame
onready var marginContainer = $MarginContainer

#=Misc=Vars=#

var element
var sub_element

var large



var image setget set_image

var video setget set_video
#==Functions==#


#=Inbuilds=#


#=Setters=#
func set_path(p):
	if element.type == "quizes":
		Global.get(element.type)[element.name]["questions"][sub_element.index][0][0][get_index()] = p

	yield(get_tree(), "idle_frame")
	if p:
		if p.get_extension() in ["png", "jpg", "svg"]:
			self.image = p
		elif p.get_extension() in ["mp4"]:
			self.video = p
	
func set_image(i):
	videoPlayer.visible = false
	imageTexture.visible = true
	if i:
		image = i
	else: 
		image = "res://res/icons/icon_image.svg"
	imageTexture.texture = load(image)
	var t_size = imageTexture.texture.get_size()
	var frame_size = Vector2(rect_size.x, t_size.y/t_size.x*rect_size.x)
	if rect_size.y < rect_size.x and rect_size.y < frame_size.y:
		frame_size = Vector2(frame_size.x/frame_size.y*rect_size.y, rect_size.y)
	
	button.rect_size = rect_size
	imageTexture.rect_size = rect_size
	if t_size.x < t_size.y:
		frame_size = Vector2(t_size.x/t_size.y*rect_size.y, rect_size.y)
		frame.rect_position.y = 0
		
	frame.rect_position.y = (rect_size.y - frame_size.y)/2.0 
	frame.rect_position.x = (rect_size.x - frame_size.x)/2.0 
	frame.rect_size = frame_size
	
func set_video(v):
	if v:
		videoPlayer.stream = load(v)
		videoPlayer.visible = true
		image.visible = false
	



#=Getters=#

#=Custom=#


#=Signals=#

func _on_ImageButton_pressed() -> void:
	if Main.edit:
		Main.file_function = [self, "set_path"]
		Main.open_res()
	else:
		if !large:
			sub_element.view_large()


func _on_ImageButton_button_down() -> void:
	frame.modulate = Global.colors["Green"][1]


func _on_ImageButton_button_up() -> void:
	frame.modulate = Global.colors["Green"][0]


func _on_ImageButton_mouse_entered() -> void:
	frame.modulate = Global.colors["Green"][0]


func _on_ImageButton_mouse_exited() -> void:
	frame.modulate = Color(0, 0, 0, 0)
