extends Control

onready var quizVBox = $QuizVBox
onready var questions = $QuizVBox/Questions
onready var previousButton = $QuizVBox/HBoxContainer/PreviousButton
onready var nextButton = $QuizVBox/HBoxContainer/NextButton
onready var questionCounter = $QuizVBox/QuestionCounter

var c_question = 0 setget set_c_question

var edit_mode = false setget set_edit_mode

var node = null


func _ready() -> void:
	for q in range(len(Global.quizes[name])):
		var question = preload("res://src/ui/Quiz/Question.tscn").instance()
		question.quiz = self
		question.question = q
		questions.add_child(question)
	self.c_question = 0

		
		
		
		
func set_c_question(c):
	yield(get_tree(), "idle_frame")
	c_question = c
	for q in questions.get_children():
		q.visible = false
	questions.get_child(c_question).visible = true
	
	questionCounter.text = str(c_question+1) + "/" + str(questions.get_child_count())
	# disable buttons
	previousButton.disabled = c_question == 0
	if !edit_mode:
		nextButton.text = ">"
		nextButton.disabled = c_question == len(Global.quizes[name]) -1
	elif c_question == len(Global.quizes[name]) -1:
		nextButton.disabled = false
		nextButton.text = "+"
	else:
		nextButton.disabled = false
		nextButton.text = ">"
		
	
		
		
func set_edit_mode(e):
	edit_mode = e
	self.c_question = c_question
	questionCounter.text = str(c_question+1) + "/" + str(questions.get_child_count())
	for q in questions.get_children():
		q.edit = e
	
		
func add_question():
	Global.quizes[name].append(Global.default_question.duplicate(true))
	var question = preload("res://src/ui/Quiz/Question.tscn").instance()
	question.quiz = self
	question.question = c_question + 1
	questions.get_child(c_question).deleteButton.modulate = Color(1, 1, 1, 1)
	questions.get_child(c_question).deleteButton.disabled = false
	questions.add_child(question)
	
	question.edit = true
	node.size = 1 + log(len(Global.quizes[name]))/9.0
	self.c_question += 1

func _on_EditButton_pressed() -> void:
	self.edit_mode = !edit_mode


func _on_PreviousButton_pressed() -> void:
	c_question -= 1
	self.c_question %= questions.get_child_count()


func _on_NextButton_pressed() -> void:
	
	if !edit_mode or c_question != len(Global.quizes[name]) -1:
		c_question += 1
		self.c_question %= questions.get_child_count()
	else:
		add_question()
		
