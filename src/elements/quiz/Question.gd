extends VBoxContainer



onready var answers = $ScrollContainer/MarginContainer/Answers

onready var editAnswers = $ScrollContainer/MarginContainer/EditAnswers
onready var addAnswerButton = $AddAnswerButton
onready var emptyBox = $EmptyBox
onready var deleteButton = $MarginContainer/DeleteButton

onready var largeViewIV = $LargeViewIV

onready var qBox = $QuestionBox
onready var textBox = $QuestionBox/Text/HBoxText/Text
onready var imageVideoSlide = $QuestionBox/ImageVideoSlide
onready var imageVideoBox = $QuestionBox/ImageVideoSlide/HBoxImageVideo/ImageVideo
onready var audioBox = $QuestionBox/Audio/HBoxAudio

onready var nextButtonIV = $QuestionBox/ImageVideoSlide/HBoxImageVideo/NextButtonIV
onready var previousButtonIV = $QuestionBox/ImageVideoSlide/HBoxImageVideo/PreviousButtonIV
onready var slideCountLabelIV = $QuestionBox/ImageVideoSlide/SlideCountLabel
onready var deleteButtonIV = $QuestionBox/ImageVideoSlide/HBoxImageVideo/Node2D/DeleteButtonIV


onready var nextButtonT = $QuestionBox/Text/HBoxText/NextButtonT
onready var previousButtonT = $QuestionBox/Text/HBoxText/PreviousButtonT
onready var slideCountLabelT = $QuestionBox/Text/SlideCountLabel
onready var deleteButtonT = $QuestionBox/Text/HBoxText/Node2D/DeleteButtonT


var answer_order = []

var tab_index = 0
var q_indeces = [0, 0, 0, 0] setget set_q_indeces
var q_sizes = [0, 0, 0]
var index
var quiz

func set_question_num(q):
	index = q
	
	set_question(Global.quizes[quiz.name]["questions"][index][0])
	set_answers()

func _ready() -> void:
	imageVideoSlide.sub_element = self
	largeViewIV.sub_element = self

	set_question(Global.quizes[quiz.name]["questions"][index][0])
	answer_order = range(len(Global.quizes[quiz.name]["questions"][index][1]))
	answer_order.shuffle()
	set_answers()
	edit()

func edit():
	answers.visible = !Main.edit
	emptyBox.visible = !Main.edit
	editAnswers.visible = Main.edit
	addAnswerButton.visible = Main.edit
	

		
	for c in textBox.get_children():
		c.edit()
		
	for c in audioBox.get_children():
		c.edit()
	
	
	
	if Main.edit and quiz.questions.get_child_count() > 1:
		deleteButton.modulate = Global.std_c
		deleteButton.disabled = false
		
	else:
		deleteButton.modulate = Color(0, 0, 0, 0)
		deleteButton.disabled = true
	
	self.q_indeces = q_indeces

	if bool(q_sizes[0]) or Main.edit:
		previousButtonIV.modulate = Global.std_c
		previousButtonIV.disabled = false
		nextButtonIV.modulate = Global.std_c
		nextButtonIV.disabled = false
		slideCountLabelIV.modulate = Global.std_c
		
	else:
		previousButtonIV.modulate = Color(0,0,0,0)
		previousButtonIV.disabled = true
		nextButtonIV.modulate = Color(0,0,0,0)
		nextButtonIV.disabled = true
		slideCountLabelIV.modulate = Color(0,0,0,0)
	
	# image video
	if q_sizes[0] == 0 and Global.quizes[quiz.name]["questions"][index][0][0][0] == Global.default_image:
		imageVideoSlide.visible = Main.edit
	else:
		imageVideoSlide.visible = true
	
	deleteButtonIV.visible = Main.edit
	
	previousButtonT.visible = bool(q_sizes[2]) or Main.edit
	nextButtonT.visible = bool(q_sizes[2]) or Main.edit
	slideCountLabelT.visible = bool(q_sizes[2])
	deleteButtonT.visible = Main.edit
	#set_question(Global.quizes[quiz.name]["questions"][question][0])
	set_answers()

func set_question(q):
	
	# image
	var a = Global.quizes[quiz.name]["questions"][index][0][0]
	for c in imageVideoBox.get_children():
		c.free()
	
	for i in a:
		var new_IV = preload("res://src/elements/quiz/ImageVideo.tscn").instance()
		new_IV.element = quiz
		new_IV.sub_element = self
		imageVideoBox.add_child(new_IV)
		new_IV.set_path(i)
		
		
		
	# audio
	for i in range(audioBox.get_child_count()):
		audioBox.get_child(i).path = q[1][i]
		audioBox.get_child(i).quiz = quiz
		audioBox.get_child(i).question = index
		
	# text
	for i in range(textBox.get_child_count()):
		textBox.get_child(i).text = q[2][i]
		textBox.get_child(i).quiz = quiz
		textBox.get_child(i).question = index
	

func set_answers():
	for c in answers.get_children():
		c.queue_free()
	for c in editAnswers.get_children():
		c.queue_free()
	

	for i in answer_order:
		var answer = preload("res://src/elements/Quiz/QuizButton.tscn").instance()
		answers.add_child(answer)
		answer.correct = Global.quizes[quiz.name]["questions"][index][1][i][0]
		answer.text = Global.quizes[quiz.name]["questions"][index][1][i][1]
		
		var editAnswer = preload("res://src/elements/Quiz/QuizRow.tscn").instance()
		editAnswers.add_child(editAnswer)
		editAnswer.quiz = quiz.name
		editAnswer.answer = i
		editAnswer.question = index
		editAnswer.correct = Global.quizes[quiz.name]["questions"][index][1][i][0]
		editAnswer.text = Global.quizes[quiz.name]["questions"][index][1][i][1]
		

func set_q_indeces(q):
	q_indeces = q
	for c in imageVideoBox.get_children():
		c.visible = false
		
	if largeViewIV.visible:
		for c in largeViewIV.control.get_node("ImageVideoSlide/HBoxImageVideo/ImageVideo").get_children():
			c.visible = false
		
	for c in textBox.get_children():
		c.visible = false
		
	imageVideoBox.get_child(q_indeces[0]).visible = true
	if largeViewIV.visible:
		largeViewIV.control.get_node("ImageVideoSlide/HBoxImageVideo/ImageVideo").get_child(q_indeces[0]).visible = true
	textBox.get_child(q_indeces[2]).visible = true
	
	
	if q_indeces[0] == q_sizes[0] and Main.edit:
		nextButtonIV.text = "+"
	else:
		nextButtonIV.text = ">"
		
	if q_indeces[2] == q_sizes[2] and Main.edit:
		nextButtonT.text = "+"
	else:
		nextButtonT.text = ">"
		
	slideCountLabelIV.text = str(q_indeces[0]+1) + "/" + str(q_sizes[0]+1)
	slideCountLabelT.text = str(q_indeces[2]+1) + "/" + str(q_sizes[2]+1)
	if largeViewIV.visible:
		largeViewIV.control.get_node("ImageVideoSlide").slideCountLabelIV.text = str(q_indeces[0]+1) + "/" + str(q_sizes[0]+1)
	
	previousButtonIV.disabled = q_sizes[0] < 1
	previousButtonT.disabled = q_sizes[2] < 1
	
	deleteButtonIV.disable(q_sizes[0] < 1)
	deleteButtonT.disable(q_sizes[2] < 1)

	


func view_large():
	var new_IV = preload("res://src/elements/quiz/ImageVideoSlide.tscn").instance()
	largeViewIV.control.add_child(new_IV)
	largeViewIV.control.rect_min_size = Vector2(2400, 1800)
	largeViewIV.control.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	new_IV.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	new_IV.IV.get_child(0).free()
	for c in imageVideoBox.get_children():
		
		var new_qIV = preload("res://src/elements/quiz/ImageVideo.tscn").instance()
		new_IV.IV.add_child(new_qIV)
		new_qIV.element = quiz
		new_qIV.sub_element = self
		new_qIV.frame.visible = false
		new_qIV.image = c.image
		new_qIV.video = c.video
	
	new_IV.sub_element = self
	new_IV.slideCountLabelIV.add_font_override("font", load("res://res/fonts/LargFont.tres"))
	largeViewIV.control.move_child(new_IV, 0)
	largeViewIV.visible = true
	new_IV.get_node("HBoxImageVideo/Node2D/DeleteButtonIV").visible = false
	edit()
	
func exit_large_view():
	largeViewIV.control.get_child(0).queue_free()
	largeViewIV.visible = false


func previous_IV():
	if q_sizes[0] > 0:
		q_indeces[0] -= 1
		q_indeces[0] += q_sizes[0] + 1
		self.q_indeces[0] %= q_sizes[0] + 1
		edit()

func next_IV():
	if !Main.edit or q_indeces[0] != q_sizes[0]:
		q_indeces[0] += 1
		self.q_indeces[0] %= q_sizes[0] + 1
	else:
		add_IV()
	edit()

func add_IV():
	var new_slide = preload("res://src/elements/quiz/ImageVideo.tscn").instance()
	Global.quizes[quiz.name]["questions"][index][0][0].append("res://res/icons/icon_image.svg")
	new_slide.element = quiz
	new_slide.sub_element = self
	imageVideoBox.add_child(new_slide)
	new_slide.set_path(Global.default_image)
	q_sizes[0] += 1
	self.q_indeces[0] += 1
	
func delete_IV():
	imageVideoBox.get_child(q_indeces[0]).free()
	q_sizes[0] -= 1
	Global.quizes[quiz.name]["questions"][index][0][0].remove(q_indeces[0])
	if q_sizes[0] < q_indeces[0]:
		self.q_indeces[0] -= 1
	edit()

func add_audio():
	var new_audio = preload("res://src/elements/quiz/QuestionAudio.tscn").instance()
	audioBox.add_child(new_audio)

func delete_audio():
	audioBox.get_child(q_indeces[1]).queue_free()
	q_sizes[1] -= 1
	Global.quizes[quiz.name]["questions"][index][0][1].remove(q_indeces[1])
	edit()


func add_text():
	var new_text = preload("res://src/elements/quiz/QuestionText.tscn").instance()
	textBox.add_child(new_text)

func delete_text():
	audioBox.get_child(q_indeces[2]).queue_free()
	q_sizes[2] -= 1
	Global.quizes[quiz.name]["questions"][index][0][2].remove(q_indeces[2])
	edit()



# Signals
func _on_AddAnswerButton_pressed() -> void:
	Global.quizes[quiz.name]["questions"][index][1].append([false, "Answer"])
	answer_order.append(len(answer_order))
	set_answers()


func _on_DeleteButton_pressed() -> void:
	Global.quizes[quiz.name]["questions"].remove(index)
	for c in quiz.questions.get_children():
		if c.question > index:
			c.set_question_num(c.question -1)
	queue_free()
	if quiz.c_question == 0:
		quiz.c_question = quiz.c_question
	else:
		quiz.c_question -= 1
	quiz.edit()




func _on_PreviousButtonT_pressed() -> void:
	if q_sizes[2] > 0:
		q_indeces[2] -= 1
		q_indeces[2] += q_sizes[0] + 1
		self.q_indeces[2] %= q_sizes[2] + 1
		edit()


func _on_NextButtonT_pressed() -> void:
	if !Main.edit or q_indeces[2] != q_sizes[2]:
		q_indeces[2] += 1
		self.q_indeces[2] %= q_sizes[2] + 1
	else:
		add_text()
	edit()


func _on_DeleteButtonIV_pressed() -> void:
	delete_IV()


func _on_DeleteButtonT_pressed() -> void:
	delete_text()


