extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var slime4_quiz_collision = $YSort/enemies/Slime4/quiz/CollisionShape2D
onready var slime3_quiz_collision = $YSort/enemies/Slime3/quiz/CollisionShape2D
onready var slime3 = $YSort/enemies/Slime3
onready var slime4 = $YSort/enemies/Slime4

############## arrow path and path ######################
onready var path_to_researchcenter = $classoria_instituteOutside/CollisionShape2D
onready var arrow_path_gate = $arrow_path_gate
onready var arrow_path_research = $arrow_path_research
############## arrow path and path ######################
################# escaped variable ######################
onready var stone1 = $YSort/enemies/escape/infinite_stone
onready var stone2 = $YSort/enemies/escape/infinite_stone2
onready var stone3 = $YSort/enemies/escape/infinite_stone3
onready var stone4 = $YSort/enemies/escape/infinite_stone4
onready var stone5  = $YSort/enemies/escape/infinite_stone5
onready var stone6  = $YSort/enemies/escape/infinite_stone6
onready var stone7  = $YSort/enemies/escape/infinite_stone7
onready var stone8  = $YSort/enemies/escape/infinite_stone8
onready var stone9  = $YSort/enemies/escape/infinite_stone9
onready var stone10  = $YSort/enemies/escape/infinite_stone10
################# escaped variable ######################
var current_map = "res://levels/Chapter2_maps/classoriaMain.tscn"
var starting_player_position = Vector2  (25, -429)
var bat_ids_to_check = ["demon1", "demon2","demon3","demon4","demon5","demon6","demon7","demon8","demon9","demon10","stone1","stone2","stone3","stone4"] 

onready var final_boss_trigger = $final_boss/CollisionShape2D
onready var gate = $classoria_Gates/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_appearance()
	set_overall_initial_position()
	set_player_position()
	checking_stage3()
	place_name.text = "Classoria Market Center"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	GlobalCanvasModulate.apply_trigger("night")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/deadnight.wav")


func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif int(Dialogic.get_variable("gandalf")) == 9:
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('starter1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif int(Dialogic.get_variable("gandalf")) == 11:
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		final_boss_trigger.disabled = false
		gate.disabled = true
		var new_dialog = Dialogic.start('starter2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
			#print("Player position set from ", target_node_path)
	else:
		print("3")
		player.global_position = Global.get_player_current_position()

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func end_intructions(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()
######### escape mission #################
func enemy_appearance():
	if int(Dialogic.get_variable("gandalf")) != 11:
		stone1.queue_free()
		stone2.queue_free()
		stone3.queue_free()
		stone4.queue_free()
		stone5.queue_free()
		stone6.queue_free()
		stone7.queue_free()
		stone8.queue_free()
		stone9.queue_free()
		stone10.queue_free()
	else:
		print(Dialogic.get_variable("gandalf"))
		print("escaped enemies was alive")
######### escape mission #################
######### Accessing stage 3 #################
func checking_stage3():
	if Global2.is_badge_complete("badge23"):
		slime4_quiz_collision.disabled = false
		path_to_researchcenter.disabled = false
		arrow_path_research.show()
	elif Global2.is_badge_complete("badge22"):
		slime3_quiz_collision.disabled = false
	else:
		slime3.queue_free()
		slime4.queue_free()


############## interactions ################




func _on_Area2D_body_shape_enteredbug1(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Which loop guarantees that the code inside will run at least once, even if the condition is false initially?")
	Global2.set_answers(0, "While loop")
	Global2.set_answers(1, "Do-while loop")
	Global2.set_answers(2, "For loop")
	Global2.set_answers(3, "None of the above")
	Global2.set_feedback(0, "Incorrect. A while loop checks the condition before running the code.")
	Global2.set_feedback(1, "Correct! A do-while loop runs the code block at least once.")
	Global2.set_feedback(2, "Incorrect. A for loop also checks the condition before executing the code.")
	Global2.set_feedback(3, "Incorrect. The do-while loop guarantees at least one execution.")
	Global2.set_picture_path(0, "res://intro/picture/question/chapter2/level2/stage5/Final Output1.png")
	
	Global2.set_question(1, "Which loop is best suited for iterating a specific number of times?")
	Global2.set_answers(4, "While loop")
	Global2.set_answers(5, "Do-while loop")
	Global2.set_answers(6, "For loop")
	Global2.set_answers(7, "None of the above")
	Global2.set_feedback(4, "Incorrect. A while loop is more flexible for unknown iterations. Consider the loop that is structured for a known count.")
	Global2.set_feedback(5, "Incorrect. A do-while loop still depends on a condition and may not limit iterations.")
	Global2.set_feedback(6, "Correct! The for loop is ideal for scenarios with a predefined number of iterations.")
	Global2.set_feedback(7, "Incorrect. An infinite loop doesn't stop and isn't used for specific counts. Think about loops with clear starting and ending points.")
	Global2.set_picture_path(1, "res://intro/picture/question/chapter2/level2/stage5/Final Output2.png")
	
	Global2.set_question(2, "In which loop is the condition checked after the execution of the code block?")
	Global2.set_answers(8, "While loop")
	Global2.set_answers(9, "Do-while loop")
	Global2.set_answers(10, "For loop")
	Global2.set_answers(11, "None of the above")
	Global2.set_feedback(8, "Incorrect. The condition is checked before running the code block. Think about which loop allows for post-condition checks.")
	Global2.set_feedback(9, "Incorrect. A for loop checks the condition before each iteration, not after.")
	Global2.set_feedback(10, "Correct! This loop checks the condition after executing the code block.")
	Global2.set_feedback(11, "Incorrect. The do-while loop is specifically designed for this purpose.")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level2/stage5/Final Output3.png" )
	
	Global2.set_question(3, "Which loop can run continuously if the condition is not properly defined?")
	Global2.set_answers(12, "For loop")
	Global2.set_answers(13, "Do-while loop")
	Global2.set_answers(14, "While loop")
	Global2.set_answers(15, "All of the above")
	Global2.set_feedback(12, "Incorrect. A for loop can run indefinitely if the condition is always true. Consider all loop types.")
	Global2.set_feedback(13, "Incorrect. A do-while loop can also run indefinitely based on its condition.")
	Global2.set_feedback(14, "Incorrect. A while loop can run indefinitely if the condition is never false.")
	Global2.set_feedback(15, "Correct! Any of these loops can run indefinitely with a mismanaged condition.")
	Global2.set_picture_path(3, "res://intro/picture/question/chapter2/level2/stage5/Final Output4.png")
	
	Global2.set_question(4, "What will happen if the condition of a while loop is never false?")
	Global2.set_answers(16, "run once")
	Global2.set_answers(17, "run contonuously")
	Global2.set_answers(18, "not run")
	Global2.set_answers(19, "None")
	Global2.set_feedback(16, "Incorrect. It will keep running as long as the condition is true.")
	Global2.set_feedback(17, "Correct! If the condition remains true, the loop will never stop.")
	Global2.set_feedback(18, "Incorrect. It runs if the condition is true.")
	Global2.set_feedback(19, "Incorrect. The correct answer is that it will run indefinitely.")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/level2/stage5/Final Output5.png")
	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_2 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_3 = true
	Global2.correct_answer_ch4_4 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug5"
	print("quiz on bug 2 is activated")
	print(Global.from_level)
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func _on_Area2D_body_shape_enteredbug2(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Which type of loop always runs at least once?")
	Global2.set_answers(0, "for")
	Global2.set_answers(1, "while")
	Global2.set_answers(2, "do-while")
	Global2.set_answers(3, "foreach")
	Global2.set_feedback(0, "Incorrect. A for loop only runs if the condition is true from the start.")
	Global2.set_feedback(1, "Incorrect. A while loop might not run if the condition is false initially.")
	Global2.set_feedback(2, "Correct! A do-while loop checks the condition after executing the loop body.")
	Global2.set_feedback(3, "Incorrect. A foreach loop iterates over a collection, but it doesn't guarantee at least one iteration.")
	
	
	Global2.set_question(1, "Which loop is best used when the number of iterations is known in advance?")
	Global2.set_answers(4, "While")
	Global2.set_answers(5, "Do-while")
	Global2.set_answers(6, "For")
	Global2.set_answers(7, "infinite")
	Global2.set_feedback(4, "Incorrect. A while loop is more flexible for unknown iterations. Consider the loop that is structured for a known count.")
	Global2.set_feedback(5, "Incorrect. A do-while loop still depends on a condition and may not limit iterations.")
	Global2.set_feedback(6, "Correct! The for loop is ideal for scenarios with a predefined number of iterations.")
	Global2.set_feedback(7, "Incorrect. An infinite loop doesn't stop and isn't used for specific counts. Think about loops with clear starting and ending points.")
	
	
	Global2.set_question(2, "Which loop type is best when you don’t know how many iterations are needed?")
	Global2.set_answers(8, "For")
	Global2.set_answers(9, "While")
	Global2.set_answers(10, "Do-While")
	Global2.set_answers(11, "Break")
	Global2.set_feedback(8, "Incorrect. A for loop is used when the iteration count is known.")
	Global2.set_feedback(9, "Correct! A while loop runs as long as a condition remains true, without a fixed number of iterations.")
	Global2.set_feedback(10, "Incorrect. A do-while loop also works with unknown iterations but always runs at least once.")
	Global2.set_feedback(11, "Incorrect. break is used to exit loops early, not for uncertain iteration counts.")
	
	
	Global2.set_question(3, "What can be used to exit a loop early?")
	Global2.set_answers(12, "return")
	Global2.set_answers(13, "continue")
	Global2.set_answers(14, "break")
	Global2.set_answers(15, "skip")
	Global2.set_feedback(12, "Incorrect. return is used to exit methods, not loops.")
	Global2.set_feedback(13, "Incorrect. continue skips the current iteration but doesn't exit the loop.")
	Global2.set_feedback(14, "Correct! The break statement exits the loop immediately.")
	Global2.set_feedback(15, "Incorrect. skip is not a valid C# keyword for exiting a loop.")
	
	
	Global2.set_question(4, "What keyword skips the rest of the loop iteration and moves to the next one?")
	Global2.set_answers(16, "break")
	Global2.set_answers(17, "continue")
	Global2.set_answers(18, "exit")
	Global2.set_answers(19, "stop")
	Global2.set_feedback(16, "Incorrect. break exits the entire loop, not just the current iteration.")
	Global2.set_feedback(17, "Correct! The continue statement skips the current iteration and proceeds with the next one.")
	Global2.set_feedback(18, "Incorrect. exit is used for terminating an application, not skipping loop iterations.")
	Global2.set_feedback(19, "Incorrect. stop is not a valid C# keyword for loop control.")
	
	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_3 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_2 = true
	Global2.correct_answer_ch4_3 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug6"
	print("quiz on bug 2 is activated")
	
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func _on_quiz_body_shape_entered_slime3(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "What is the output?")
	Global2.set_answers(0, "3")
	Global2.set_answers(1, "6")
	Global2.set_answers(2, "9")
	Global2.set_answers(3, "0")
	Global2.set_feedback(0, "Incorrect. The loop adds 1 + 2 + 3, so the result is higher.")
	Global2.set_feedback(1, "Correct! The loop adds 1 + 2 + 3, giving a sum of 6.")
	Global2.set_feedback(2, "Incorrect. 9 is too high for this loop.")
	Global2.set_feedback(3, "Incorrect. The sum is updated inside the loop.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/level2/analyzing/Question - 1.png")
	
	Global2.set_question(1, "What is the output?")
	Global2.set_answers(4, "2")
	Global2.set_answers(5, "4")
	Global2.set_answers(6, "0")
	Global2.set_answers(7, "1")
	Global2.set_feedback(4, "Correct! The loop runs twice: for i = 0 and i = 2, so count becomes 2.")
	Global2.set_feedback(5, "Incorrect. The loop increments i by 2, so it only runs twice.")
	Global2.set_feedback(6, "Incorrect. The count is incremented in the loop.")
	Global2.set_feedback(7, "Incorrect. The loop runs twice, not once.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level2/analyzing/Question - 2.png")
	
	Global2.set_question(2, "What is the output?")
	Global2.set_answers(8, "1 2")
	Global2.set_answers(9, "1 2 3")
	Global2.set_answers(10, "1")
	Global2.set_answers(11, "0")
	Global2.set_feedback(8, "Correct! The loop prints 1, then 2, and stops because i becomes 3.")
	Global2.set_feedback(9, "Incorrect. The loop stops before printing 3.")
	Global2.set_feedback(10, "Incorrect. The loop runs more than once.")
	Global2.set_feedback(11, "Incorrect. i starts at 1, not 0.")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level2/analyzing/Question - 3.png")
	
	Global2.set_question(3, "What can be used to exit a loop early?")
	Global2.set_answers(12, "return")
	Global2.set_answers(13, "continue")
	Global2.set_answers(14, "break")
	Global2.set_answers(15, "skip")
	Global2.set_feedback(12, "Incorrect. return is used to exit methods, not loops.")
	Global2.set_feedback(13, "Incorrect. continue skips the current iteration but doesn't exit the loop.")
	Global2.set_feedback(14, "Correct! The break statement exits the loop immediately.")
	Global2.set_feedback(15, "Incorrect. skip is not a valid C# keyword for exiting a loop.")
	
	Global2.set_question(4, "What keyword skips the rest of the loop iteration and moves to the next one?")
	Global2.set_answers(16, "break")
	Global2.set_answers(17, "continue")
	Global2.set_answers(18, "exit")
	Global2.set_answers(19, "stop")
	Global2.set_feedback(16, "Incorrect. break exits the entire loop, not just the current iteration.")
	Global2.set_feedback(17, "Correct! The continue statement skips the current iteration and proceeds with the next one.")
	Global2.set_feedback(18, "Incorrect. exit is used for terminating an application, not skipping loop iterations.")
	Global2.set_feedback(19, "Incorrect. stop is not a valid C# keyword for loop control.")

	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/slime(classoria).tres")
	Global2.correct_answer_ch1_2 = true
	Global2.correct_answer_ch2_1 = true
	Global2.correct_answer_ch3_1 = true
	Global2.correct_answer_ch4_3 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug7"
	print("quiz on bug 2 is activated")
	
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func _on_quiz_body_shape_entered_slime4(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Complete the for loop to print numbers from 1 to 5.")
	Global2.set_answers(0, "i <= 5")
	Global2.set_answers(1, "i < 5")
	Global2.set_answers(2, "i >= 5")
	Global2.set_answers(3, "i == 5")
	Global2.set_feedback(0, "Correct! The loop will run from 1 to 5 as required.")
	Global2.set_feedback(1, "Incorrect. This will only print numbers from 1 to 4.")
	Global2.set_feedback(2, "Incorrect. The loop condition will not run.")
	Global2.set_feedback(3, "Incorrect. The loop will not iterate as needed.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/level2/fill/New question - 1.png")
	
	Global2.set_question(1, "Fix this while loop to stop when x is less than 5.")
	Global2.set_answers(4, "x > 5")
	Global2.set_answers(5, "x < 5")
	Global2.set_answers(6, "x == 5")
	Global2.set_answers(7, "x <= 5")
	Global2.set_feedback(4, "Incorrect. The loop will not run with this condition.")
	Global2.set_feedback(5, "Correct! The loop runs while x is less than 5.")
	Global2.set_feedback(6, "Incorrect. This will make the loop never run.")
	Global2.set_feedback(7, "Partially correct, but this will print up to 5, not 4.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level2/fill/New question - 2.png")
	
	Global2.set_question(2, "Complete the do-while loop to keep asking for input until the user enters 'n'.")
	Global2.set_answers(8, "input == 'n'")
	Global2.set_answers(9, "input != 'n'")
	Global2.set_answers(10, "input = 'n'")
	Global2.set_answers(11, "input > 'n'")
	Global2.set_feedback(8, "Incorrect. This will stop the loop after one input.")
	Global2.set_feedback(9, "Correct! The loop will continue until the user enters 'n'.")
	Global2.set_feedback(10, "Incorrect. This is an assignment, not a comparison.")
	Global2.set_feedback(11, "Incorrect. Strings are compared differently in C#.")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level2/fill/New question - 3.png")
	
	Global2.set_question(3, "Fix the for loop to count down from 5 to 1.")
	Global2.set_answers(12, "i > 1")
	Global2.set_answers(13, "i <= 1")
	Global2.set_answers(14, "i >= 1")
	Global2.set_answers(15, "i != 1")
	Global2.set_feedback(12, "Incorrect. This will stop at 2, not 1.")
	Global2.set_feedback(13, "Incorrect. This condition is backwards for counting down.")
	Global2.set_feedback(14, "Correct! This will print from 5 down to 1.")
	Global2.set_feedback(15, "Incorrect. This will skip 1.")
	Global2.set_picture_path(3, "res://intro/picture/question/chapter2/level2/fill/New question - 4.png")
	
	Global2.set_question(4, "Finish the loop to sum numbers from 1 to 3.")
	Global2.set_answers(16, "i <= 3")
	Global2.set_answers(17, "i > 3")
	Global2.set_answers(18, "i == 3")
	Global2.set_answers(19, "i < 3")
	Global2.set_feedback(16, "Correct! This will sum 1 + 2 + 3.")
	Global2.set_feedback(17, "Incorrect. The loop will never run.")
	Global2.set_feedback(18, "Incorrect. This will only add 3.")
	Global2.set_feedback(19, "Incorrect. This will only sum 1 + 2.")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/level2/fill/New question - 5.png")
	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/slime(classoria).tres")
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_2 = true
	Global2.correct_answer_ch3_2 = true
	Global2.correct_answer_ch4_3 = true
	Global2.correct_answer_ch5_1 = true
	Global2.dialogue_name = "bug8"
	print("quiz on bug 2 is activated")
	
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func _on_final_boss_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	
	Global2.set_question(0, "Begin your attack into the enemy. Start on ZERO value")
	Global2.set_answers(0, "int i = 0")
	Global2.set_feedback(0, "The answer should be 'int i = 0'")
	Global2.set_picture_path(0, "res://intro/picture/question/chapter2/level2/stage5/Final Output1.png")
	
	Global2.set_question(1, "Attack him 3 times, make sure that i is < three")
	Global2.set_answers(1, "i < 3")
	Global2.set_feedback(1, "The answer should be 'i < 3'")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level2/stage5/Final Output2.png" )
	
	Global2.set_question(2, "Increment the i value by 1")
	Global2.set_answers(2, "i++")
	Global2.set_feedback(2, "The answer should be 'i++'")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level2/stage5/Final Output3.png" )
	
	Global2.set_question(3, "Put braces into it indicating its inside process")
	Global2.set_answers(3, "{}")
	Global2.set_feedback(3, "The answer should be '{}'")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/level2/stage5/Final Output4.png")
	
	Global2.set_question(4, "Put the value of i in console.writeline to dispay the output and attack the enemy")
	Global2.set_answers(4, "i")
	Global2.set_feedback(4, "The answer should be 'i'")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/level2/stage5/Final Output5.png")
	
	Global2.dialogue_name = "bug9"
	var new_dialog = Dialogic.start('commanderbug')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "fight_boss")

func fight_boss(timelineend):
	pass
