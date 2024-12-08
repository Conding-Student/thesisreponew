extends Control
onready var saven_load = $saving_file
# Question data (with 30 questions, answers, correct answers, and optional images)
var question_answers = {
	"questions": [
		"In a flowchart, what does a diamond shape usually represent?", #1
		"Complete the pseudocode by inputting a and b. The result must be 'a is larger'", #2
		"Pseudocode is written using _______ language rather than exact programming syntax.", #3
		"Which shape is typically used to represent the start and end of a flowchart?", #4
		"A tool that can be used to write a preliminary plan for the development of a computer program.", #5
		"If age = 15 after undergoing conditional statements what would be the ouput?", #6
		"Your equal points is 50 (point = 50) after undergoing conditional statements what will this code print?", #7
		"Your speed is currently at 120 mph what will be your current status?", #8
		"You have 5 oranges, via given conditional statement below was it equal to 10 or not?", #9
		"The current temperature is 85 (temp = 85) after undergoing conditional statements what would be the ouput?", #10
		"What happens if there’s no break in a switch case?", #11
		"Identify the wrong shapes, did you notice what shape should'nt use in decision making?", #12
		"When would you use if-else instead of switch?", #13
		"What is the default case in a switch for?", #14
		"What happens if none of the conditions in an if-else statement are true and there's no else?", #15
		"Which loop guarantees that the code inside will run at least once, even if the condition is false initially?", #16
		"What can be used to exit a loop early?", #17
		"Connect the two connectors by identifying the missing letter inside the highlighted connector symbol", #18
		"What keyword skips the rest of the loop iteration and moves to the next one?", #19
		"Which of the following flowchart symbols is used to represent a process or action?", #20
		"In which loop is the condition checked after the execution of the code block?", #21
		"Complete the right way to declare a variable.", #22
		"Complete the right way to declare a variable.", #23
		"How do you declare a class?", #24
		"What does the Main() do?", #25
		"Which access modifier prohibits to gain access from outside the class?", #26
		"Which access modifier allows access from outside the class?", #27
		"How does a class perceive in C#?", #28
		"How do you call a method in a class?", #29
		"What does the get and set method control?" #30
	],
	"answers": [
		["Decision", "Process", "Input / Output", "Connectors"], #1
		["a < b", "a > b", "d > c", "d < c"], #2
		["Spanish", "Tagalog", "English", "Japanese"], #3
		["Oval", "Rectangle", "Square", "Diamond"], #4
		["Pseudocode", "IDE", "Magnifier", "Machine"], #5
		["Adult", "Teen", "Child", "None of the above"], #6
		["Almost", "Winner", "Try Again", "None of the above"], #7
		["Fast", "Too Fast", "Safe", "None of the above"], #8
		["Not Equal", "Equal", "Child", "None of the above"], #9
		["Hot", "Warm", "Cold", "None of the above"], #10
		["Skip", "Crash", "Fall through", "Exit"], #11
		["Circle", "Rectangle", "Square", "Parellelogram"], #12 
		["Simple variable", "Complex logic", "Many cases", "String values"], #13
		["Handle error", "Final case", "Break", "Restart"], #14
		["Crash", "Skip", "Run if", "Error"], #15
		["While loop", "Do-while loop", "For loop", "None of the above"], #16
		["return", "continue", "break", "skip"], #17
		["D", "C", "A", "B"], #18 
		["break", "continue", "exit", "stop"], #19
		["Oval", "Rectangle", "Square", "Diamond"], #20
		["None of the above", "While loop", "Do-while loop", "For loop"], #21
		["String", "Float", "Int", "Double"], #22
		["Int", "Double", "Char", "Float"], #23
		["ClassName class {}", "obj.fields", "obj.methods", "class ClassName {}"], #24
		["Execution start", "Instance", "Inheritance", "Method call"], #25
		["Public", "Private", "Protected", "Static"], #26
		["Private", "Protected", "Public", "Static"], #27
		["Loop", "Method", "Variable", "Blueprint"], #28
		["object.method()", "class()", "class..method", "Return"], #29
		["Loops", "Fields", "Methods", "Classes"] #30
	],
	"correct_answer": [
		[true, false, false, false],  # Correct answer for Q1 m1
		[false, true, false, false],  # Correct answer for Q2 m1
		[false, false, true, false],  # Correct answer for Q3 m1
		[true, false, false, false],  # Correct answer for Q4 m1
		[true, false, false, false],  # Correct answer for Q5 m1
		[false, true, false, false],  # Correct answer for Q6 m2 
		[true, false, false, false],  # Correct answer for Q7 m2
		[true, false, false, false],  # Correct answer for Q8 m2
		[true, false, false, false],  # Correct answer for Q9 m2
		[false, true, false, false],  # Correct answer for Q10 m2
		[false, false, true, false],  # Correct answer for Q11 m3
		[false, false, false, true],  # Correct answer for Q12 m1
		[false, true, false, false],  # Correct answer for Q13 m3
		[false, true, false, false],  # Correct answer for Q14 m3
		[false, true, false, false],  # Correct answer for Q15 m3
		[false, true, false, false],  # Correct answer for Q16 m3
		[false, false, true, false],  # Correct answer for Q17 m3
		[false, false, true, false],  # Correct answer for Q18 m1
		[false, true, false, false],  # Correct answer for Q19 m3
		[false, true, false, false],  # Correct answer for Q20 m1
		[false, false, false, true],  # Correct answer for Q21 m3
		[false, false, true, false],  # Correct answer for Q22 m2
		[false, false, false, true],  # Correct answer for Q23 m2
		[false, false, false, true],  # Correct answer for Q24 m4
		[true, false, false, false],  # Correct answer for Q25 m4
		[false, true, false, false],  # Correct answer for Q26 m4
		[false, false, true, false],  # Correct answer for Q27 m4
		[false, false, false, true],  # Correct answer for Q28 m4
		[true, false, false, false],  # Correct answer for Q29 m4
		[false, true, false, false]   # Correct answer for Q30 m4
	],
	"images": [
		null,  # Image for Q1
		"res://intro/picture/question/stage4_q1.png",  # No image for Q2
		null,  # No image for Q3
		"res://intro/picture/question/Flowchart_shape_unit1.png",  # No image for Q4
		null,  # Image for Q5
		"res://intro/picture/question/chapter2/if else/If Else Question - 2.png",  # No image for Q6
		"res://intro/picture/question/chapter2/if else/If Else Question - 3.png",  # No image for Q7
		"res://intro/picture/question/chapter2/if else/If Else Question - 4.png",  # No image for Q8
		"res://intro/picture/question/chapter2/if else/If Else Question - 7.png",  # No image for Q9
		"res://intro/picture/question/chapter2/if else/If Else Question - 1.png",  # No image for Q10
		null,  # No image for Q11
		"res://intro/picture/question/level2/stage3/Question 1.png",  # No image for Q12
		null,  # No image for Q13
		null,  # No image for Q14
		null,  # No image for Q15
		null,  # No image for Q16
		null,  # No image for Q17
		"res://intro/picture/question/level2/stage3/Question 2 .png",  # No image for Q18
		null,  # No image for Q19
		"res://intro/picture/question/Flowchart_shape_unit1.png",  # No image for Q20
		null,  # No image for Q21
		"res://intro/picture/question/level3/stage4/Lvl 3 Stage 4 - 1.png",  # No image for Q22
		"res://intro/picture/question/level3/stage4/Lvl 3 Stage 4 - 2.png",  # No image for Q23
		null,  # No image for Q24
		null,  # No image for Q25
		null,  # No image for Q26
		null,  # No image for Q27
		null,  # No image for Q28
		null,  # No image for Q29
		null   # No image for Q30
	]
}
var current_question_index = 0  # Track the current question
var score = 0  # Track the user's overall score

onready var question_label = $Question/q1  # Question label
onready var choices_panel = $action_panel/choices1  # Parent panel of buttons
onready var choices1 = $action_panel/choices1/ch1_1  # Button 1
onready var choices2 = $action_panel/choices1/ch1_2  # Button 2
onready var choices3 = $action_panel/choices1/ch1_3  # Button 3
onready var choices4 = $action_panel/choices1/ch1_4  # Button 4
onready var question_code_picture = $bg_pic5  # Image control for the question
onready var play_button = $Play_button

func _ready():
	# Connect the button signals to handle the selected answer
	choices1.connect("pressed", self, "_on_choice_selected", [0])
	choices2.connect("pressed", self, "_on_choice_selected", [1])
	choices3.connect("pressed", self, "_on_choice_selected", [2])
	choices4.connect("pressed", self, "_on_choice_selected", [3])
	
	# Display the first question and its answers
	display_question()

# Display the current question, answers, and image (if available)
func display_question():
	question_label.text = question_answers["questions"][current_question_index]
	choices1.text = question_answers["answers"][current_question_index][0]
	choices2.text = question_answers["answers"][current_question_index][1]
	choices3.text = question_answers["answers"][current_question_index][2]
	choices4.text = question_answers["answers"][current_question_index][3]
	var image_path = question_answers["images"][current_question_index]
	if image_path != null:
		question_code_picture.texture = load(image_path)
		question_code_picture.show()
	else:
		question_code_picture.hide()

# Handle when the user selects an answer
func _on_choice_selected(choice_index):
	if question_answers["correct_answer"][current_question_index][choice_index]:
		score += 1  # Add points for the correct answer
		update_module_score(current_question_index)  # Update the respective module's score
	
	current_question_index += 1  # Move to the next question
	
	if current_question_index < question_answers["questions"].size():
		display_question()
	else:
		save_final_score()

# Update the module score based on the current question
func update_module_score(question_index):
	match question_index:
		0, 1, 2, 3, 4, 11, 17, 19:  # Questions belonging to module 1
			Global2.ptm1 += 1
		5, 6, 7, 8, 9, 21, 22:  # Questions belonging to module 2
			Global2.ptm2 += 1
		10, 12, 13, 14, 15, 16, 18:  # Questions belonging to module 3
			Global2.ptm3 += 1
		23, 24, 25, 26, 27, 28, 29:  # Questions belonging to module 4
			Global2.ptm4 += 1

# Store the final score in the singleton
func save_final_score():
	Global2.post_final_score = score  # Save the final score in the singleton
	show_final_score()

# Show the final score once all questions are answered
func show_final_score():
	
	question_label.text = "NRI: " + str(Global2.calculate_and_display_nri())
	choices_panel.hide()  # Hide the buttons once the quiz is over
	question_code_picture.hide()  # Hide the image after the quiz
	play_button.show()
	saven_load.auto_save_file()
	print(Global2.prm1)
	print(Global2.prm2)
	print(Global2.prm3)
	print(Global2.prm4)
	print("postest:")
	print(Global2.ptm1)
	print(Global2.ptm2)
	print(Global2.ptm3)
	print(Global2.ptm4)

func _on_Play_button_pressed():
	var new_dialog = Dialogic.start('bug18')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")
	

func end_intructions(timelineend):
	SceneTransition.change_scene("res://intro/Main_menu.tscn")
