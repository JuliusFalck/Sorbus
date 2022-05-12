extends PanelContainer

#==Variables==#
#=Children=#
onready var label = $Label
onready var button = $Button

#=Misc=Vars=#
var pos
var move 
var start_pos
var double = false
var selected = false
var pre_select = false

var text = "New Label" setget set_text


#==Functions==#


#=Inbuilds=#
func _process(delta: float) -> void:
	if move:
		var d = get_global_mouse_position() - start_pos
		self.pos += d

#=Setters=#
func set_text(t):
	text = t

#=Getters=#


#=Custom=#
func select(s):
	self.selected = s
	Main.map.selected = self if selected else null
	
#=Signals=#
func _on_Button_pressed() -> void:
	match Main.map.c_tool:
		"Select":
			if double:
				select(true)
				Main.view.open(self)
				pre_select = false
			else:
				pre_select = selected
				if !pre_select:
					select(!selected)
				double = true
				yield(get_tree().create_timer(0.2),"timeout")
				if pre_select:
					select(!selected)
				double = false
		
		"Link":
			Main.map.link(self)
			
			
		

func _on_Button_button_down() -> void:
	modulate = Global.color_palette[1]
	if Main.map.c_tool == "Move":
		start_pos = get_global_mouse_position()
		move = true

func _on_Button_button_up() -> void:
	if Main.map.c_tool == "Move":
		move = false


func _on_Button_mouse_entered() -> void:
	if !selected:
		modulate = Global.color_palette[0]


func _on_Button_mouse_exited() -> void:
	if !selected:
		modulate = Color(1, 1, 1, 1)

