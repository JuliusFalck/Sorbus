extends Control

onready var quizVBox = $QuizVBox
onready var questions = $QuizVBox/Questions
onready var previousButton = $QuizVBox/HBoxContainer/PreviousButton
onready var nextButton = $QuizVBox/HBoxContainer/NextButton
onready var questionCounter = $QuizVBox/HBoxContainer/QuestionCounter
onready var dSettingsPanel = $DependenceSettingsPanel

var givers = {}
var takers = {}

var c_question = 0 setget set_c_question


var node = null

var type = "quizes"



func edit():

	for q in questions.get_children():
		q.edit()
	if len(Global.quizes[name]["questions"]) == 1:
		previousButton.visible = Main.edit
		nextButton.visible = Main.edit
	else:
		previousButton.visible = true
		nextButton.visible = true
	
func refresh():
	generate()
	
	
func set_c_question(c):

	c_question = c
	for q in questions.get_children():
		q.visible = false
	questions.get_child(c_question).visible = true
	
	questionCounter.text = str(c_question+1) + "/" + str(questions.get_child_count())
	# disable buttons
	previousButton.disabled = c_question == 0
	if !Main.edit:
		nextButton.text = ">"
		nextButton.disabled = c_question == len(Global.quizes[name]["questions"]) -1
	elif c_question == len(Global.quizes[name]["questions"]) -1:
		nextButton.disabled = false
		nextButton.text = "+"
	else:
		nextButton.disabled = false
		nextButton.text = ">"
		
	
	
		
func add_question():
	Global.quizes[name]["questions"].append(Global.default_question.duplicate(true))
	var question = preload("res://src/elements/Quiz/Question.tscn").instance()
	question.quiz = self
	question.index = c_question + 1
	questions.get_child(c_question).deleteButton.modulate = Color(1, 1, 1, 1)
	questions.get_child(c_question).deleteButton.disabled = false
	questions.add_child(question)
	question.edit()
	node.size = 1 + log(len(Global.quizes[name]["questions"]))/9.0
	self.c_question += 1


func generate():
	if len(givers) > 0:
		Global.quizes[name]["questions"] = []
		for c in questions.get_children():
			c.queue_free()
	for k in givers.keys():
		match k[0]:
			"lists":
				for i in Global.lists[k[1]]["items"]:
					var picks = Global.lists[k[1]]["items"].duplicate()
					picks.erase(i)
					var ans = [[true, i.title]]
					for j in range(givers[k]["answer_count"]-1):
						var index = randi()%len(picks)
						ans.append([false, picks[index].title])
						picks.remove(index)
					var IV = i.IV
					if IV == []:
						print(i.title)
						IV = [Global.default_image]
					var audio = i.audio
					if i.audio == []:
						audio = [null]
					Global.quizes[name]["questions"].append([
						[IV, audio, [i.description]],
						ans
					])
	

	var order = range(len(Global.quizes[name]["questions"]))
	order.shuffle()
	for q in order:
		var question = preload("res://src/elements/Quiz/Question.tscn").instance()
		question.quiz = self
		question.index = q
		questions.add_child(question)
	yield(get_tree(), "idle_frame")
	self.c_question = 0
	edit()




func _on_PreviousButton_pressed() -> void:
	c_question -= 1
	self.c_question %= questions.get_child_count()


func _on_NextButton_pressed() -> void:
	
	if !Main.edit or c_question != len(Global.quizes[name]["questions"]) -1:
		c_question += 1
		self.c_question %= questions.get_child_count()
	else:
		add_question()
		
