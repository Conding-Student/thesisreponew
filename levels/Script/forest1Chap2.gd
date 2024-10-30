extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var gandalf = $YSort/Gandalf
onready var gandalf_sprite = $YSort/Gandalf/Sprite
onready var gandalf_collision = $YSort/Gandalf/Area2D/CollisionShape2D
var current_map = "res://levels/Chapter2_maps/forest1Chap2.tscn"
var starting_player_position = Vector2  (36, 52)

##############1ST BUG ########################
onready var bug2_collision_question = $YSort/bugs/bug2/quiz/CollisionShape2D
onready var bug1_collision_question = $YSort/bugs/bug1/quiz/CollisionShape2D
onready var bug1_hitbox = $YSort/bugs/bug1/Hitbox/CollisionShape2D
onready var bug2_hitbox = $YSort/bugs/bug2/Hitbox/CollisionShape2D
##############1ST BUG ########################

##############CHAPTER 3  BUG ########################
onready var bug5_collision_question = $YSort/bugs/bug5/quiz/CollisionShape2D
onready var bug6_collision_question = $YSort/bugs/bug6/quiz/CollisionShape2D
onready var varbug5_hitbox = $YSort/bugs/bug5/Hitbox/CollisionShape2D
onready var varbug6_hitbox = $YSort/bugs/bug6/Hitbox/CollisionShape2D
onready var bug5_sprite = $YSort/bugs/bug5
onready var bug6_sprite = $YSort/bugs/bug6
#onready var bug5_hitbox = $YSort/bugs/bug5/hi

##############CHAPTER 3 BUG ########################
#analexius
onready var anal = $YSort/analexius

#path to the next map
onready var lock_path = $YSort/Area2D/CollisionShape2D
onready var to_gandalf_home = $gandalfHouse_Outside/CollisionShape2D
onready var path_arrow = $YSort/path/path_arrow
# Called when the node enters the scene tree for the first time.
func _ready():

	set_overall_initial_position()
	set_player_position()
	place_name.text = "Old Syntaxia forest"
	resume.connect("pressed", self, "resume_the_game")
	gandalf.connect("start_dialogue", self, "hide_controller")
	gandalf.connect("end_dialogue", self, "show_instruction")
	anal.connect("start_dialogue", self, "hide_controller")
	anal.connect("end_dialogue", self, "badge18")
	checking_gandalf_appearance()
	checking_analexius_appearance()
	bug_question()
	cheking_bug5_6_appearance()
	morning_setup()
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	#changescene()
func set_player_position():
	
	if  int(Dialogic.get_variable("gandalf")) == 0:
		print("dialogue trigger")
		introduction()
		player.global_position = starting_player_position
	elif Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			print("3")
		else:
			#pass
			print("4")
	else:
		player.global_position = Global.get_player_current_position()
		print("5")

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())


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

############## interactions ################
func badge18():
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()
	anal.badge18_complete()
	anal.queue_free()
func hide_controller():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()

func show_instruction():
	hide_controller()
	gandalf.queue_free()
	to_gandalf_home.disabled = false
	path_arrow.show()
	var new_dialog = Dialogic.start('finding_house')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func introduction():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	var new_dialog = Dialogic.start('c2level1p1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func end_intructions(timelineend):
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()

func checking_gandalf_appearance():
	if int(Dialogic.get_variable("gandalf")) == 0: #if the first interaction with gandalf is not done this will happen
		gandalf_sprite.show()
		gandalf_collision.disabled = false
		to_gandalf_home.disabled = true
		path_arrow.hide()
	else: #trigger when gandalf is done meeting
		#pass
		lock_path.disabled = true
		to_gandalf_home.disabled = false
		path_arrow.show()
		gandalf.queue_free()
		#print("this one is tiggered")

func checking_analexius_appearance():
	if int(Dialogic.get_variable("gandalf")) != 5: #if the first interaction with gandalf is not done this will happen
		anal.queue_free()
	else:
		anal.show()
		print("error in fetching gandalf value to erase analexius")
func changescene():
	if Global2.is_badge_complete("badge17"):
		SceneTransition.change_scene("res://levels/Chapter2_maps/forest2Chap2.tscn")
	else:
		print("badge17 is not yet trigger to change scene")

func bug_question():
	if Global2.is_badge_complete("badge16") or int(Dialogic.get_variable("gandalf")) == 16 or int(Dialogic.get_variable("gandalf")) == 17:
		#can be remove
		#$YSort/bugs/bug1.queue_free()
		#$YSort/bugs/bug2.queue_free()
		bug1_collision_question.disabled = false
		bug2_collision_question.disabled = false
		bug2_hitbox.disabled = true
		bug1_hitbox.disabled = true
	else:
		bug1_collision_question.disabled = true
		bug2_collision_question.disabled = true

func cheking_bug5_6_appearance():
	if  int(Dialogic.get_variable("gandalf")) != 16:
		bug5_sprite.queue_free()
		bug6_sprite.queue_free()
	else:
		varbug5_hitbox.disabled = true
		varbug6_hitbox.disabled = true
func morning_setup():
	if int(Dialogic.get_variable("gandalf")) == 4 or int(Dialogic.get_variable("gandalf")) == 5 or int(Dialogic.get_variable("gandalf")) == 6:
		GlobalCanvasModulate.apply_trigger("morning")
	elif int(Dialogic.get_variable("gandalf")) == 7 or int(Dialogic.get_variable("gandalf")) == 8:
		GlobalCanvasModulate.apply_trigger("night")
	else:
		print("dialogic gandalf")

func _on_quizbug2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "What operator should use to add the earned coins to your total.")
	Global2.set_answers(0, "==")
	Global2.set_answers(1, ">= ")
	Global2.set_answers(2, "+=")
	Global2.set_answers(3, "--")
	Global2.set_feedback(0, "Incorrect. == is used for comparison, not addition.")
	Global2.set_feedback(1, "Incorrect. >= is a comparison operator for greater than or equal to.")
	Global2.set_feedback(2, "Correct! += adds the earned coins to your total.")
	Global2.set_feedback(3, "Incorrect. -- decreases a value by 1, not adds to it.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/level question/Stage 2 - 1.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	
	Global2.set_question(1, "What operator should use to increment your mana to fight this enemy longer?")
	Global2.set_answers(4, "<")
	Global2.set_answers(5, "> ")
	Global2.set_answers(6, "++")
	Global2.set_answers(7, "--")
	Global2.set_feedback(4, "Incorrect. < is a comparison operator for 'less than,' not for incrementing.")
	Global2.set_feedback(5, "Incorrect. > is a comparison operator for 'greater than,' not for incrementing.")
	Global2.set_feedback(6, "Correct! ++ increments your mana by 1.")
	Global2.set_feedback(7, "Incorrect. -- decreases a value by 1, not adds to it.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level question/Stage 2 - 2.png")
	
	Global2.set_question(2, "What operator should use to check if health is less than 30.")
	Global2.set_answers(8, "<")
	Global2.set_answers(9, "> ")
	Global2.set_answers(10, "<=")
	Global2.set_answers(11, "==")
	Global2.set_feedback(8, "Correct! < is used to check if health is less than 30.")
	Global2.set_feedback(9, "Incorrect. > checks if a value is greater, not less.")
	Global2.set_feedback(10, "Incorrect. <= checks if a value is less than or equal to, but the question only asks for 'less than'.")
	Global2.set_feedback(11, "Incorrect. == checks for equality, not whether a value is less than another.")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level question/Stage 2 - 3.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	
	Global2.set_question(3, "What happens if none of the conditions in an if-else statement are true and there's no else?")
	Global2.set_answers(12, "Crash")
	Global2.set_answers(13, "Skip")
	Global2.set_answers(14, "Run if")
	Global2.set_answers(15, "Error")
	Global2.set_feedback(12, "Incorrect. The program doesn’t crash without an else.")
	Global2.set_feedback(13, "Correct. If no condition is true and there’s no else, the block is skipped.")
	Global2.set_feedback(14, "Incorrect. The if block only runs if its condition is true.")
	Global2.set_feedback(15, "Incorrect! There’s no error if the else is missing.")
	
	Global2.set_question(4, "What is the default case in a switch for?")
	Global2.set_answers(16, "Handle error")
	Global2.set_answers(17, "Final case")
	Global2.set_answers(18, "Break")
	Global2.set_answers(19, "Restart")
	Global2.set_feedback(16, "Incorrect. The default isn’t for handling errors—it’s for unmatched cases.")
	Global2.set_feedback(17, "Correct! The default runs when no other case matches, kind of like an else.")
	Global2.set_feedback(18, "Incorrect. break is used to exit cases, not default.")
	Global2.set_feedback(19, "Incorrect.  The default doesn’t restart the switch.")
	
	Global.load_game_position = true
	Global2.correct_answer_ch1_3 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_1 = true
	Global2.correct_answer_ch4_2 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug2"
	print("quiz on bug 2 is activated")
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")

#bug1
func _on_quiz_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "What statement to use to be able for you to heal or attack based on your health.")
	Global2.set_answers(0, "drift-check")
	Global2.set_answers(1, "outfit-check")
	Global2.set_answers(2, "if-else")
	Global2.set_answers(3, "win-loss")
	Global2.set_feedback(0, "Incorrect. This isn't a valid statement in C#.")
	Global2.set_feedback(1, "Incorrect. This is not a valid statement in programming")
	Global2.set_feedback(2, "Correct! if-else allows you to make decisions based on your health condition.")
	Global2.set_feedback(3, "Incorrect. This is not a valid control statement in C#.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/level question/Stage 2 - 4.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	
	Global2.set_question(1, "What operator should use to subtract 10 from the inventory?")
	Global2.set_answers(4, "<")
	Global2.set_answers(5, "> ")
	Global2.set_answers(6, "++")
	Global2.set_answers(7, "--")
	Global2.set_feedback(4, "Incorrect. < is a comparison operator for 'less than,' not for subtraction.")
	Global2.set_feedback(5, "Incorrect. > is a comparison operator for 'greater than,' not for subtraction.")
	Global2.set_feedback(6, "Incorrect. ++ increments a value by 1, not subtracts.")
	Global2.set_feedback(7, "Correct! -- subtracts 1, but if you want to subtract 10, use inventory -= 10;.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/level question/Stage 2 - 5.png")
	
	Global2.set_question(2, "What operator should use to increment the counter")
	Global2.set_answers(8, "<")
	Global2.set_answers(9, "> ")
	Global2.set_answers(10, "<=")
	Global2.set_answers(11, "++")
	Global2.set_feedback(8, "Invorrect! < is a comparison operator for 'less than,' not for addition.")
	Global2.set_feedback(9, "Incorrect. > checks if a value is greater, not for addition")
	Global2.set_feedback(10, "Incorrect. <= checks if a value is less than or equal to, but the question only asks for 'less than'.")
	Global2.set_feedback(11, "Correct. ++ it increament the counter value by 1")
	Global2.set_picture_path(2,"res://intro/picture/question/chapter2/level question/Stage 2 - 6.png")
	Global2.load_enemy_data("res://Battlescenes/tres/big_bug.tres")
	
	Global2.set_question(3, "What happens if there’s no break in a switch case?")
	Global2.set_answers(12, "Skip")
	Global2.set_answers(13, "Crash")
	Global2.set_answers(14, "Fall through")
	Global2.set_answers(15, "Exit")
	Global2.set_feedback(12, "Incorrect. Without a break, it doesn’t skip the case, it runs the next one.")
	Global2.set_feedback(13, "Incorrect. The program doesn’t crash, it continues running.")
	Global2.set_feedback(14, "Correct. Without break, it falls through and executes the next case.")
	Global2.set_feedback(15, "Incorrect! It doesn’t exit automatically; it needs break to stop running cases.")
	
	Global2.set_question(4, "When would you use if-else instead of switch?")
	Global2.set_answers(16, "Simple variable")
	Global2.set_answers(17, "Complex logic")
	Global2.set_answers(18, "Many cases")
	Global2.set_answers(19, "String values")
	Global2.set_feedback(16, "Incorrect. switch works best for checking a single variable with set values.")
	Global2.set_feedback(17, "Correct! if-else is more flexible for multiple conditions and complex logic.")
	Global2.set_feedback(18, "Incorrect. switch is better when you have many cases to check.")
	Global2.set_feedback(19, "Incorrect.  Both if-else and switch can handle strings, but complexity matters here.")
	
	Global.load_game_position = true
	Global2.correct_answer_ch1_3 = true
	Global2.correct_answer_ch2_4 = true
	Global2.correct_answer_ch3_4 = true
	Global2.correct_answer_ch4_3 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug1"
	print("quiz on bug 2 is activated")
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func _on_quiz_body_shape_entered_chapter3bug5(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "How does a class perceive in C#?")
	Global2.set_answers(0, "Method")
	Global2.set_answers(1, "Variable ")
	Global2.set_answers(2, "Blueprint")
	Global2.set_answers(3, "Loop")
	Global2.set_feedback(0, "Incorrect. A method defines the functionality of a class, not a class blueprint")
	Global2.set_feedback(1, "Incorrect.  A variable holds data, but a class structures objects")
	Global2.set_feedback(2, "Correct! class is a blueprint of an object.")
	Global2.set_feedback(3, "Incorrect. A loop controls repetition, not object creation")
	
	Global2.set_question(1, "What is a method in C#?")
	Global2.set_answers(4, "Variable")
	Global2.set_answers(5, "Block")
	Global2.set_answers(6, "Loop")
	Global2.set_answers(7, "Data type")
	Global2.set_feedback(4, "Incorrect. Variables store data, but methods perform tasks.")
	Global2.set_feedback(5, "Correct. A method defines the functionality of a class.")
	Global2.set_feedback(6, "Incorrect. Loops control flow, not the execution of tasks.")
	Global2.set_feedback(7, "Incorrect! Data types define the kind of data, not actions.")

	
	Global2.set_question(2, "How do you call a method in a class?")
	Global2.set_answers(8, "Create")
	Global2.set_answers(9, "class()")
	Global2.set_answers(10, "object.method()")
	Global2.set_answers(11, "Return ")
	Global2.set_feedback(8, "Incorrect! Methods are not called using create, they need an object or class reference.")
	Global2.set_feedback(9, "Incorrect. A method call doesn't use the class name directly without an object.")
	Global2.set_feedback(10, "Correct. First you need to use the object name and use dot to call the method in that class that turns into object")
	Global2.set_feedback(11, "Incorrect. return is for output, not method invocation.")

	Global2.set_question(3, "Which access modifier allows access from outside the class?")
	Global2.set_answers(12, "Private")
	Global2.set_answers(13, "Public")
	Global2.set_answers(14, "Protected")
	Global2.set_answers(15, "Static")
	Global2.set_feedback(12, "Incorrect! Private modifier are prohibits values to be accessible outside the class")
	Global2.set_feedback(13, "Correct. Using public modifiers allows the values of the class to be accessible outside of it.")
	Global2.set_feedback(14, "Incorrect. Protected restricts access to the class and its inheritors.")
	Global2.set_feedback(15, "Incorrect. Static refers to class-level access, not public visibility")
	
	Global2.set_question(4, "Which keyword returns a value in a method?")
	Global2.set_answers(16, "Void")
	Global2.set_answers(17, "Return")
	Global2.set_answers(18, "Static")
	Global2.set_answers(19, "Call")
	Global2.set_feedback(16, "Incorrect! void specifies no return value")
	Global2.set_feedback(17, "Correct. Return keywords allows the method to return a values or result.")
	Global2.set_feedback(18, "Incorrect. Static refers to class-level methods, not returning values.")
	Global2.set_feedback(19, "Incorrect. Call is not used in C# for returning values")
	
	Global2.load_enemy_data("res://Battlescenes/tres/bugs5lives.tres")
	Global.load_game_position = true
	Global2.correct_answer_ch1_3 = true
	Global2.correct_answer_ch2_2 = true
	Global2.correct_answer_ch3_3 = true
	Global2.correct_answer_ch4_2 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug10"
	print("quiz on bug 2 is activated")
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func _on_quiz_body_shape_entered_chapter3bug6(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "How do you access a static member?")
	Global2.set_answers(0, "Object")
	Global2.set_answers(1, "Class")
	Global2.set_answers(2, "Variable")
	Global2.set_answers(3, "Return")
	Global2.set_feedback(0, "Incorrect. An object isn't needed for static members; they're called on the class.")
	Global2.set_feedback(1, "Correct.  Using class we can get an access into a static member class")
	Global2.set_feedback(2, "Incorrect! Variables are fields, not ways to call static members.")
	Global2.set_feedback(3, "Incorrect. Return is used in methods, not for accessing static members.")
	
	Global2.set_question(1, "What does the get and set method control?")
	Global2.set_answers(4, "Loops")
	Global2.set_answers(5, "Fields")
	Global2.set_answers(6, "Methods")
	Global2.set_answers(7, "Classes")
	Global2.set_feedback(4, "Incorrect. Loops manage repetition, not field access.")
	Global2.set_feedback(5, "Correct. It sets and get the value of the fields")
	Global2.set_feedback(6, "Incorrect. Methods are functions used for process and put functionality into a class, but get and set are used for setting and getting field values.")
	Global2.set_feedback(7, "Incorrect! Classes define structure, not individual field access.")

	
	Global2.set_question(2, "Which access modifier prohibits to gain access from outside the class?")
	Global2.set_answers(8, "Private")
	Global2.set_answers(9, "Public")
	Global2.set_answers(10, "Protected")
	Global2.set_answers(11, "Static")
	Global2.set_feedback(8, "Correct! It makes sure that the fields or variable can't be access directly outside of the class")
	Global2.set_feedback(9, "Incorrect. It fact, this was the contrast of the right asnwer because it publicize the fields or variables to be accessible anytime.")
	Global2.set_feedback(10, "Incorrect. It also prohibit but the fields or values can be access when there is a Child class")
	Global2.set_feedback(11, "Incorrect. Static refers to class-level access, not public visibility.")

	Global2.set_question(3, "What does the Main() do?")
	Global2.set_answers(12, "Instance")
	Global2.set_answers(13, "Inheritance")
	Global2.set_answers(14, "Method call")
	Global2.set_answers(15, "Execution start")
	Global2.set_feedback(12, "Incorrect! Instances aren’t created until after Main() starts.")
	Global2.set_feedback(13, "Incorrect. Main() is not related to inheritance, but to program execution.")
	Global2.set_feedback(14, "Incorrect. Main() is not called by other methods but is the entry point.")
	Global2.set_feedback(15, "Correct. It’s where the program starts")
	
	Global2.set_question(4, " How do you declare a class?")
	Global2.set_answers(16, "class ClassName {}")
	Global2.set_answers(17, "obj.methods")
	Global2.set_answers(18, "obj.fields")
	Global2.set_answers(19, "ClassName class {}")
	Global2.set_feedback(16, "Correct! Class keywords must be the first to be declare followed by Classname and {}")
	Global2.set_feedback(17, "Incorrect. This was not a proper syntax it should start in class keywords.")
	Global2.set_feedback(18, "Incorrect. This was not a proper syntax it should start in class keywords.")
	Global2.set_feedback(19, "Incorrect. It must start with class keywords before the ClassName.")
	
	Global2.load_enemy_data("res://Battlescenes/tres/bugs5lives.tres")
	Global.load_game_position = true
	Global2.correct_answer_ch1_2 = true
	Global2.correct_answer_ch2_2 = true
	Global2.correct_answer_ch3_1 = true
	Global2.correct_answer_ch4_4 = true
	Global2.correct_answer_ch5_1 = true
	Global2.dialogue_name = "bug11"
	print("quiz on bug 2 is activated")
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func lock_path_dialogue(body_rid, body, body_shape_index, local_shape_index):
	hide_controller()
	var new_dialog = Dialogic.start('pathdialogue')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")
