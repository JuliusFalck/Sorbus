extends Node


#==Variables==#
#=Children=#
onready var searchBar = $PanelContainer/VBoxContainer/SearchBar
onready var results = $PanelContainer/VBoxContainer/ScrollContainer/Results

#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#


#=Setters=#


#=Getters=#

#=Custom=#
func search():
	var s = searchBar.text
	var result = []
	var ins = []
	
	for c in results.get_children():
		c.queue_free()
		
	for i in Global.data_types:
		for e in Global.get(i).keys():
			if e.begins_with(s):
				result.append([i, e])
			elif s in e:
				ins.append([i, e])
	
	for i in result:
		var si = preload("res://src/ui/general/SearchItem.tscn").instance()
		si.name = i[1]
		results.add_child(si)
		if Global.get(i[0])[i[1]]["icon"]:
			si.icon.texture = load(Global.get(i[0])[i[1]]["icon"])
		si.label.text = i[1]
		si.type = i[0]
		
	
	for i in ins:
		var si = preload("res://src/ui/general/SearchItem.tscn").instance()
		si.name = i[1]
		results.add_child(si)
		if Global.get(i[0])[i[1]]["icon"]:
			si.icon.texture = load(Global.get(i[0])[i[1]]["icon"])
		si.label.text = i[1]
		si.type = i[0]
	
	
#=Signals=#


func _on_SearchBar_text_changed(new_text: String) -> void:
	search()
