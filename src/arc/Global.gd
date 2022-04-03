extends Node

#==Data==#
var nodes = {}

var links = {}

#=Types=#
var quizes = {}

var notes = {}

var figures = {}

var charts = {}



var data_types = [quizes, notes, figures, charts]

var default_question = ["What animal is fastest?", 
[[true, "Pronghorn"], [false, "Tiger"],
 [false, "Gnu"], [false, "Ostrich"]]]

	
var sf = Vector2(1, 1) setget , get_scale_factor
var standartd_size = Vector2(3840, 2060)



func _ready() -> void:
	randomize()


# Data

func get_data(n):
	for i in data_types:
		if i.has(n):
			return i[n]

func set_data(n, v):
	for i in data_types:
		if i.has(n):
			i[n] = v
			
func rename(o, n):
	for i in data_types:
		if i.has(o):
			i[n] = i[o]
			i.erase(o)
	


func get_scale_factor():
	return get_tree().get_root().size/standartd_size




func deactivate_children(p):
	for c in p.get_children():
		if c.has_method("deactivate"):
			c.deactivate()
