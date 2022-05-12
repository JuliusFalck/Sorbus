extends Line2D


#==Variables==#
#=Children=#


#=Misc=Vars=#

#==Functions==#


#=Inbuilds=#
func _set(property: String, value) -> bool:
	if property == "points":
		points = [value[0], 
				(value[0] + value[-1])/2, 
				value[-1]]
	return true

#=Setters=#


#=Getters=#


#=Custom=#

func save():
	var save_dict = {
		"name": name,
		"filename": filename,
		"parent": get_parent().get_path(),
		"points": points
		
	}
	return save_dict


#=Signals=#
