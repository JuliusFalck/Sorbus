extends VBoxContainer


onready var quizBox = $QuizBox
onready var answers = $ScrollContainer/CenterContainer/Answers
onready var editQuizBox = $EditQuizBox
onready var editAnswers = $ScrollContainer/CenterContainer/EditAnswers
onready var addAnswerButton = $AddAnswerButton
onready var emptyBox = $EmptyBox
onready var deleteButton = $DeleteButton
var edit = false setget set_edit

var question
var quiz

func set_question_num(q):
	question = q
	
	set_question(Global.quizes[quiz.name][question][0])
	set_answers(Global.quizes[quiz.name][question][1])

func _ready() -> void:
	if quiz.questions.get_child_count() == 1:
		deleteButton.modulate = Color(0, 0, 0, 0)
		deleteButton.disabled = true
	else:
		deleteButton.modulate = Color(1, 1, 1, 1)
		deleteButton.disabled = false
		
	set_question(Global.quizes[quiz.name][question][0])
	set_answers(Global.quizes[quiz.name][question][1])

func set_edit(e):
	edit = e
	quizBox.visible = !e
	answers.visible = !e
	emptyBox.visible = !e
	editQuizBox.visible = e
	editAnswers.visible = e
	addAnswerButton.visible = e
	deleteButton.visible = e
	set_question(Global.quizes[quiz.name][question][0])
	set_answers(Global.quizes[quiz.name][question][1])

func set_question(q):
	quizBox.text = q
	editQuizBox.text = q
	
	

func set_answers(a):
	for c in answers.get_children():
		c.queue_free()
	for c in editAnswers.get_children():
		c.queue_free()
	
	var r = range(len(a))
	r.shuffle()
	for i in r:
		var answer = preload("res://src/UI/Quiz/QuizButton.tscn").instance()
		answers.add_child(answer)
		answer.correct = Global.quizes[quiz.name][question][1][i][0]
		answer.text = Global.quizes[quiz.name][question][1][i][1]
		
		var editAnswer = preload("res://src/UI/Quiz/QuizRow.tscn").instance()
		editAnswers.add_child(editAnswer)
		editAnswer.quiz = quiz.name
		editAnswer.answer = i
		editAnswer.question = question
		editAnswer.correct = Global.quizes[quiz.name][question][1][i][0]
		editAnswer.text = Global.quizes[quiz.name][question][1][i][1]
		


func _on_EditQuizBox_text_changed() -> void:
	quizBox.text = editQuizBox.text
	Global.quizes[quiz.name][question][0] = editQuizBox.text


func _on_AddAnswerButton_pressed() -> void:
	Global.quizes[quiz.name][question][1].append([false, "Answer"])
	set_answers(Global.quizes[quiz.name][question][1])


func _on_DeleteButton_pressed() -> void:
	Global.quizes[quiz.name].remove(question)
	for c in quiz.questions.get_children():
		if c.question > question:
			c.set_question_num(c.question -1)
	queue_free()
	if quiz.c_question == 0:
		quiz.c_question = quiz.c_question
	else:
		quiz.c_question -= 1
	
