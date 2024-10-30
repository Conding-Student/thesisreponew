extends Control
onready var saven_load = $saving_file
# Question data (with 30 questions, answers, correct answers, and optional images)
var question_answers = {
	"questions": [
		"In a flowchart, what does a diamond shape usually represent?", "Complete the pseudocode by inputting a and b. The result must be 'a is larger'", "Pseudocode is written using _______ language rather than exact programming syntax.", "Which shape is typically used to represent the start and end of a flowchart?", "A tool that can be used to write a preliminary plan for the development of a computer program.",
		"What would be the ouput?", "What will this code print?", "What will this code print?", "What will this code print?", "What would be the output?",
		"What happens if there’s no break in a switch case?", "What operator should use to subtract 10 from the inventory?", "When would you use if-else instead of switch?", "What is the default case in a switch for?", "What happens if none of the conditions in an if-else statement are true and there's no else?",
		"Which loop guarantees that the code inside will run at least once, even if the condition is false initially?", "What can be used to exit a loop early?", "Complete the for loop to print numbers from 1 to 5.", "What keyword skips the rest of the loop iteration and moves to the next one?", "Fix this while loop to stop when x is less than 5.",
		"In which loop is the condition checked after the execution of the code block?", "Complete the right way to declare a variable.", "Complete the right way to declare a variable.", "How do you declare a class?", "What does the Main() do?",
		"Which access modifier prohibits to gain access from outside the class?", "Which access modifier allows access from outside the class?", "How does a class perceive in C#?", "How do you call a method in a class?", "What does the get and set method control?"
	],
	"answers": [
		["Decision", "Process", "Input / Output", "Connectors"],
		["a < b", "a > b", "d > c", "d < c"],
		["Spanish", "Tagalog", "English", "Japanese"],
		["Rectangle", "Square", "Diamond", "Oval"],
		["Pseudocode", "IDE", "Magnifier", "Machine"],
		["Adult", "Teen", "Child", "None of the above"],
		["Almost", "Winner", "Try Again", "None of the above"],
		["Fast", "Too Fast", "Safe", "None of the above"],
		["Not Equal", "Equal", "Child", "None of the above"],
		["Hot", "Warm", "Cold", "None of the above"],
		["Skip", "Crash", "Fall through", "Exit"],
		["<", ">", "++", "--"],
		["Simple variable", "Complex logic", "Many cases", "String values"],
		["Handle error", "Final case", "Break", "Restart"],
		["Crash", "Skip", "Run if", "Error"],
		["While loop", "Do-while loop", "For loop", "None of the above"],
		["return", "continue", "break", "skip"],
		["i <= 5", "i < 5", "i >= 5", "i == 5"],
		["break", "continue", "exit", "stop"],
		["x > 5", "x < 5", "x == 5", "x <= 5"],
		["None of the above", "While loop", "Do-while loop", "For loop"],
		["String", "Float", "Int", "Double"],
		["Int", "Double", "Char", "Float"],
		["ClassName class {}", "obj.fields", "obj.methods", "class ClassName {}"],
		["Execution start", "Instance", "Inheritance", "Method call"],
		["Public", "Private", "Protected", "Static"],
		["Private", "Protected", "Public", "Static"],
		["Loop", "Method", "Variable", "Blueprint"],
		["object.method()", "class()", "class..method", "Return"],
		["Loops", "Fields", "Methods", "Classes"]
	],
	"correct_answer": [
		[true, false, false, false],  # Correct answer for Q1
		[false, true, false, false],  # Correct answer for Q2
		[false, false, true, false],  # Correct answer for Q3
		[false, false, false, true],  # Correct answer for Q4
		[true, false, false, false],  # Correct answer for Q5
		[false, true, false, false],  # Correct answer for Q6
		[true, false, false, false],  # Correct answer for Q7
		[true, false, false, false],  # Correct answer for Q8
		[true, false, false, false],  # Correct answer for Q9
		[false, true, false, false],  # Correct answer for Q10
		[false, false, true, false],  # Correct answer for Q11
		[false, false, false, true],  # Correct answer for Q12
		[false, true, false, false],  # Correct answer for Q13
		[false, true, false, false],  # Correct answer for Q14
		[false, true, false, false],  # Correct answer for Q15
		[false, true, false, false],  # Correct answer for Q16
		[false, false, true, false],  # Correct answer for Q17
		[true, false, false, false],  # Correct answer for Q18
		[false, true, false, false],  # Correct answer for Q19
		[false, true, false, false],  # Correct answer for Q20
		[false, false, false, true],  # Correct answer for Q21
		[false, true, false, false],  # Correct answer for Q22
		[false, false, false, true],  # Correct answer for Q23
		[false, false, false, true],  # Correct answer for Q24
		[true, false, false, false],  # Correct answer for Q25
		[false, true, false, false],  # Correct answer for Q26
		[false, false, true, false],  # Correct answer for Q27
		[false, false, false, true],  # Correct answer for Q28
		[true, false, false, false],  # Correct answer for Q29
		[false, true, false, false]   # Correct answer for Q30
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
		"res://intro/picture/question/chapter2/level question/Stage 2 - 5.png",  # No image for Q12
		null,  # No image for Q13
		null,  # No image for Q14
		null,  # No image for Q15
		null,  # No image for Q16
		null,  # No image for Q17
		"res://intro/picture/question/chapter2/level2/fill/New question - 1.png",  # No image for Q18
		null,  # No image for Q19
		null,  # No image for Q20
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
var score = 0  # Track the user's score

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
	# Update the question text
	question_label.text = question_answers["questions"][current_question_index]
	
	# Update the answer choices
	choices1.text = question_answers["answers"][current_question_index][0]
	choices2.text = question_answers["answers"][current_question_index][1]
	choices3.text = question_answers["answers"][current_question_index][2]
	choices4.text = question_answers["answers"][current_question_index][3]
	
	# Update the image (if it exists)
	var image_path = question_answers["images"][current_question_index]
	if image_path != null:
		question_code_picture.texture = load(image_path)
		question_code_picture.show()  # Show the image
	else:
		question_code_picture.hide()  # Hide the image if there's none

# Handle when the user selects an answer
func _on_choice_selected(choice_index):
	if question_answers["correct_answer"][current_question_index][choice_index]:
		score += 1  # Add points for the correct answer
	
	current_question_index += 1  # Move to the next question
	
	if current_question_index < question_answers["questions"].size():
		display_question()  # Display the next question
	else:
		save_final_score()  # Save the final score in the singleton and show the final score

# Store the final score in the singleton
func save_final_score():
	Global2.post_final_score = score  # Save the final score in the singleton
	show_final_score()

# Show the final score once all questions are answered
func show_final_score():
	question_label.text = "NRI: " + str(Global2.post_final_score)
	choices_panel.hide()  # Hide the buttons once the quiz is over
	question_code_picture.hide()  # Hide the image after the quiz
	play_button.show()
	saven_load.auto_save_file()

func _on_Play_button_pressed():
	SceneTransition.change_scene("res://intro/Main_menu.tscn")
