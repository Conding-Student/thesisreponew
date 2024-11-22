extends Node

onready var saving = $saving_file


#stage 4 singleton state. Ito gamitin mo after sa videoa animation stage 4
#yungpart ng dorr activation collision. dapat lumabas yonafter makausap si merrick 
var state = ""



######################## stage complete trigger ################
# Dictionary mapping badges to their completion status
# Current state of badges
var badges_complete = {
	"badge0": true,
	"badge1": false,
	"badge2": false,
	"badge3": false,
	"badge4": false,
	"badge5": false,
	"badge6": false,
	"badge7": false,
	"badge8": false,
	"badge9": false,
	"badge10": false,
	"badge11": false,
	"badge12": false,
	"badge13": false,
	"badge14": false,
	"badge15": false,
	"badge16": false,
	"badge17": false,
	"badge18": false,
	"badge19": false,
	"badge20": false,
	"badge21": false,
	"badge22": false,
	"badge23": false,
	"badge24": false,
	"badge25": false,
	"badge26": false,
	"badge27": false,
	"badge28": false,
	"badge29": false,
	"badge30": false,
}

# Previous state of badges (initially, it's the same as badges_complete)
var previous_badges_state = badges_complete.duplicate()

# Function to check if a new badge has been added
func check_for_new_badges():
	for badge_name in badges_complete:
		var previous_status = previous_badges_state[badge_name]
		var current_status = badges_complete[badge_name]
		
		# Check if a badge has changed from false to true
		if not previous_status and current_status:
			print("New badge added: " + badge_name)
			# You can add more functionality here, like unlocking rewards or updating UI

	# Update the previous badge state to the current state after the check
	previous_badges_state = badges_complete.duplicate()

# Marks a badge as complete and displays a notification
func complete_badge(badge_name: String):
	if badges_complete.has(badge_name):
		badges_complete[badge_name] = true
		#autsosave
		saving.auto_save_file()
		print("%s badge earned!" % badge_name)

# Checks if a badge is complete
func is_badge_complete(badge_name: String) -> bool:
	return badges_complete.get(badge_name, false)

# Checks if all badges are earned
func are_all_badges_complete() -> bool:
	return not badges_complete.has_value(false)

######################## stage compelte trigger #################

################## PRE-POST TEST ###################
# Singleton (Global Script)
var pre_final_score = 0.0
var post_final_score = 0.0
var MPI = 0.0
var NRI = 0.0


# Function to calculate and display NRI
func calculate_and_display_nri():
	# Recalculate MPI based on the current pre_final_score
	MPI = 30 - pre_final_score

	# Debugging output to verify variable values
	print("pre_final_score: ", pre_final_score)
	print("post_final_score: ", post_final_score)
	print("MPI: ", MPI)

	# Ensure MPI is not zero to avoid division by zero
	if MPI != 0:
		# Recalculate NRI with explicit float conversion
		NRI = float(post_final_score - pre_final_score) / float(MPI) * 100
		
		return NRI
		# Display the NRI value
		print("NRI: ", NRI)
	else:
		return "perfect score in pre-test"
		print("perfect score in pre-test")

# This function is called when the node is added to the scene
func _ready():
	# Call the function after setting scores
	calculate_and_display_nri()
################## PRE-POST TEST ###################

################### enemy tres path ################

# Store the file path of the enemy .tres file globally
var enemy_data = null  # This will hold the loaded Resource

# Function to load the enemy data from a .tres file
func load_enemy_data(path_to_tres):
	enemy_data = load(path_to_tres)
	if enemy_data != null:
		print("Enemy data loaded successfully.")
		print("Enemy name: ", enemy_data.name)
		print("Enemy health: ", enemy_data.health)
		print("Enemy damage: ", enemy_data.damage)
	else:
		print("Failed to load enemy data.")

var bug_defeated = false
#################### enemy tres path #################

######################### DYNAMIC QUIZ VALUES #######################
# Evaluation: using dictionaries for questions, answers, and feedback
var evaluations = {
	"questions": ["", "", "", "","",""],
	"answers": ["","", "","", "", "", "","",""
	, "", "", "","", "", "", "", "", "", "", "",""],
	"feedback": ["", "", "", "","", "", "", "","",""
	, "", "", "","", "", "", "", "", "", "",""],
	"pictures_path": ["res://intro/picture/question/default_bg.png", "res://intro/picture/question/default_bg.png", "res://intro/picture/question/default_bg.png", "res://intro/picture/question/default_bg.png","res://intro/picture/question/default_bg.png","res://intro/picture/question/default_bg.png"],
}

#correct answer trigger
var correct_answer_ch1_1 = false
var correct_answer_ch1_2 = false
var correct_answer_ch1_3 = false
var correct_answer_ch1_4 = false
#Choices from 2nd question
var correct_answer_ch2_1 = false
var correct_answer_ch2_2 = false
var correct_answer_ch2_3 = false
var correct_answer_ch2_4 = false
#Choices from 3rd question
var correct_answer_ch3_1 = false
var correct_answer_ch3_2 = false
var correct_answer_ch3_3 = false
var correct_answer_ch3_4 = false
#Choices from 4th question
var correct_answer_ch4_1 = false
var correct_answer_ch4_2 = false
var correct_answer_ch4_3 = false
var correct_answer_ch4_4 = false
#Choices from 5th question
var correct_answer_ch5_1 = false
var correct_answer_ch5_2 = false
var correct_answer_ch5_3 = false
var correct_answer_ch5_4 = false

#fchange scene
var change_scene_on_question0 = false
var change_scene_on_question1 = false
var change_scene_on_question2 = false
var change_scene_on_question3 = false
var change_scene_on_question4 = false

# Array of trigger answers for each question
var trigger_answers = [
	[false, false, false, false],  # Question 1 choices
	[false, false, false, false],  # Question 2 choices
	[false, false, false, false],  # Question 3 choices
	[false, false, false, false],  # Question 4 choices
	[false, false, false, false]   # Question 5 choices
]

func reset_scene_change_flags():
	change_scene_on_question0 = false
	
	change_scene_on_question1 = false
	change_scene_on_question2 = false
	change_scene_on_question3 = false
	change_scene_on_question4 = false

func get_answer_evaluation(question_index: int) -> String:
	# Check if the index is valid
	if question_index < 0 or question_index >= evaluations["answers"].size():
		return "Invalid question index."
	
	# Retrieve and return the answer
	return evaluations["answers"][question_index]

func get_feedback_evaluation(question_index: int) -> String:
	# Check if the index is valid
	if question_index < 0 or question_index >= evaluations["feedback"].size():
		return "Invalid question index."
	
	# Retrieve and return the feedback
	return evaluations["feedback"][question_index]

# Function to reset all values to false
func reset_trigger_answers():
	for i in range(trigger_answers.size()):
		for j in range(trigger_answers[i].size()):
			trigger_answers[i][j] = false

func get_trigger_answer(question_index: int, choice_index: int) -> bool:
	if question_index < 0 or question_index >= trigger_answers.size():
		return false
	if choice_index < 0 or choice_index >= trigger_answers[question_index].size():
		return false
	return trigger_answers[question_index][choice_index]

func set_trigger_answer(question_index: int, choice_index: int, value: bool):
	if question_index >= 0 and question_index < trigger_answers.size() and choice_index >= 0 and choice_index < trigger_answers[question_index].size():
		trigger_answers[question_index][choice_index] = value


# Example usage:
#var answer = get_trigger_answer(0, 2)  # Retrieves the trigger for the 3rd choice of the 1st question
#set_trigger_answer(0, 2, false)        # Sets the trigger for the 3rd choice of the 1st question to false

#dialogue name
var dialogue_name = ""

func reset_evaluations():
	# Reset the evaluation dictionary to default values
	evaluations = {
		"questions": ["", "", "", "", "", ""],
		"answers": ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
		"feedback": ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
		"pictures_path": [
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png",
			"res://intro/picture/question/default_bg.png"
		]
	}
	
	# Reset all correct answer triggers to false
	correct_answer_ch1_1 = false
	correct_answer_ch1_2 = false
	correct_answer_ch1_3 = false
	correct_answer_ch1_4 = false
	
	correct_answer_ch2_1 = false
	correct_answer_ch2_2 = false
	correct_answer_ch2_3 = false
	correct_answer_ch2_4 = false
	
	correct_answer_ch3_1 = false
	correct_answer_ch3_2 = false
	correct_answer_ch3_3 = false
	correct_answer_ch3_4 = false
	
	correct_answer_ch4_1 = false
	correct_answer_ch4_2 = false
	correct_answer_ch4_3 = false
	correct_answer_ch4_4 = false
	
	correct_answer_ch5_1 = false
	correct_answer_ch5_2 = false
	correct_answer_ch5_3 = false
	correct_answer_ch5_4 = false
	
	# Reset scene change triggers to false
	change_scene_on_question0 = false
	change_scene_on_question1 = false
	change_scene_on_question2 = false
	change_scene_on_question3 = false
	change_scene_on_question4 = false

######################### DYNAMIC QUIZ VALUES #######################

######################### Sequence logic ############################
# Dictionary to store the history of interactions
var interaction_history = {
	"interactions": ["","","","",""]
}

# Reset function to clear all user interactions
func reset_interactions():
	for i in range(interaction_history["interactions"].size()):
		interaction_history["interactions"][i] = ""
	print("Interactions history have been reset!")
func get_answers_sequence(index: int) -> String:
	var result = interaction_history["interactions"][index]
	if result == "":
		return "perfect answer"
	return result


func get_question_sequence(index: int) -> String:
	return interaction_history["interactions"][index]
######################### Sequence Logic ############################

#Questions
func set_question(index: int, question_local: String):
	evaluations["questions"][index] = question_local

func get_question(index: int) -> String:
	return evaluations["questions"][index]
	
#answers
func set_answers(index: int, answers_local: String):
	evaluations["answers"][index] = answers_local

func get_answers(index: int) -> String:
	return evaluations["answers"][index]

#Questions
func set_feedback(index: int, feedback_local: String):
	evaluations["feedback"][index] = feedback_local

func get_feedback(index: int) -> String:
	return evaluations["feedback"][index]

func set_picture_path(index: int, picture_local: String):
	evaluations["pictures_path"][index] = picture_local
	
func get_picture_path(index: int) -> String:
	return evaluations["pictures_path"][index]
