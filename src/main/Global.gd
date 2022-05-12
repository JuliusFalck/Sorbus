extends Node

#==Data==#
var nodes = {}

var links = {}

#=Types=#
var quizes = {}

var notes = {}

var figures = {}

var charts = {}



var data_types = ["quizes", "notes", "figures", "charts"]

var default_question = ["What animal is fastest?", 
[[true, "Pronghorn"], [false, "Tiger"],
 [false, "Gnu"], [false, "Ostrich"]]]

	
var sf = Vector2(1, 1) setget , get_scale_factor
var standartd_size = Vector2(3840, 2060)

# Visual
var color_palette = [Color(0, .8, 0, 1), Color(0, .67, 0, 1)]


#=Settings=#
var save_path = "res://save/my_world.meditor"


func _ready() -> void:
	randomize()
	yield(get_tree().create_timer(1),"timeout")
	load_save()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Save"):
		save()


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
		if get(i).has(o):
			 get(i)[n] =  get(i)[o]
			 get(i).erase(o)
	

func save():
	var save_file = File.new()
	var world_nodes = []
	for n in Main.map.nodes.get_children():
		world_nodes.append(n.save())
	for n in Main.map.links.get_children():
		world_nodes.append(n.save())
		
		
	var data = {}
	data["general_data"] = []
	for d in data_types:
		data["general_data"].append(get(d))
	data["nodes"] = world_nodes
	var e = save_file.open(save_path, File.WRITE)
	print(e)
	save_file.store_var(data)
	save_file.close()
	

func load_save():
	var save_file = File.new()
	if !save_file.file_exists(save_path):
		return
	save_file.open(save_path, File.READ)
	
	var data = save_file.get_var()
	save_file.close()
	for i in range(len(data["general_data"])):
		set(data_types[i], data["general_data"][i]) 

	for node_data in data["nodes"]:
		var node = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(node)
		for i in node_data.keys():
			node.set(i, node_data[i])
		
		

func get_scale_factor():
	return get_tree().get_root().size/standartd_size




func deactivate_children(p):
	for c in p.get_children():
		if c.has_method("deactivate"):
			c.deactivate()


func to_names(v):
	var names = []
	for i in v:
		names.append(i.name)
		
	return names


# Math



func sum(a):
	var sum = a[0]
	for i in a:
		sum += i
	return sum - a[0]

func make_group_perimiter(n, pos):
	var v = []
	var sizes = []
	for i in n:
		v.append(Main.map.nodes.get_node(i).pos)
		sizes.append(Main.map.nodes.get_node(i).size)
	var area = make_group_area(v, sizes)
	for i in range(len(area)):
		area[i] -= pos 
	return area


func make_group_area(v, sizes):
	var polygon = Geometry.convex_hull_2d(v)
	var area = make_star(polygon, 80.0)

	#¤var circles = []
	#for i in range(len(v)):
		#var circle = make_circle(v[i], sizes[i]*120.0, 12)
		#area = Geometry.merge_polygons_2d(area, circle)[0]
	area = remove_sharp(area, 1.4)
	area = smooth_corner_cut(area, 2, true)
	
	
	area.append(area[0])
	return area
	

func remove_sharp(data, a):
	var new_data = []
	var l = len(data)
	var done = true
	for i in range(l):
		var m = data[(i+1)%l]
		if abs((data[(i)%l]-m).angle_to(data[(i+2)%l]-m)) > PI/a and abs((data[(i+2)%l]-m).angle_to(data[(i)%l]-m)) > PI/a:
			new_data.append(data[(i+1)%l])
		else:
			new_data.append((data[(i+1)%l]*2.0+data[(i)%l])/3.0)
			new_data.append((data[(i+1)%l]*2.0+data[(i+2)%l])/3.0)
			done = false
	if !done:
		new_data = remove_sharp(new_data, a)
	return new_data

func smooth_corner_cut(data, n, s):
	var new_data = []
	var l = len(data)
	for i in range(l):
		new_data.append(data[(i+1)%l] + (data[i] - data[(i+1)%l])/4.0)
		new_data.append(data[(i+1)%l] + (data[(i+2)%l] - data[(i+1)%l])/4.0)
	#¤if s:
		#new_data = remove_sharp(new_data, 1.25)
	if n != 0:
		new_data = smooth_corner_cut(new_data, n-1, false)
	return new_data

func make_circle(p, r, res):
	var circle = []
	for i in range(res):
		circle.append(Vector2(cos(TAU/res*i)*r, sin(TAU/res*i)*r)+p)
	return circle


func make_star(polygon, a):
	var star = []
#	if !Geometry.is_polygon_clockwise(polygon):
#		polygon = polygon.invert()
	
	var min_gap = INF
	for i in range(len(polygon)-1):
		var dis = polygon[i].distance_to(polygon[i+1])
		min_gap = dis if dis < min_gap else min_gap
	min_gap /= 4.0
	
	var pol = []
	for i in range(len(polygon)-1):
		
		var center_point = sum(polygon)/float(len(polygon))
		var dir = (polygon[(i+1)%len(polygon)]-center_point).normalized()
		var length = (polygon[(i+1)%len(polygon)]-center_point).length()
		pol.append((polygon[(i+1)%len(polygon)]-center_point)+dir*300.0+center_point)
		
		
		
	for i in range(len(pol)):
		star.append(pol[i])
		var mid = (pol[i]+pol[(i+1)%len(pol)])/2.0
		var m_0 = pol[(i+1)%len(pol)]
		var m_1 =  pol[(i+2)%len(pol)]
		var off = min(abs((pol[i]-m_0).angle_to(pol[(i+1)%len(pol)]-m_0)),abs((pol[(i+1)%len(pol)]-m_1).angle_to(pol[(i+3)%len(pol)]-m_1)))
		
		star.append(mid + mid.direction_to(pol[i]).rotated(-PI/2.0)*a*off)
		
	return star
		
		
		
		
		
		
