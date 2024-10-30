extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var analexius = $YSort/Analexius_chapter3
onready var objecthis_outside = $objectiaOutside/CollisionShape2D
#onready var path_arrow_traning = $YSort/path/path_arrow
var current_map = "res://levels/Chapter2_maps/objectiaRoad.tscn"
var starting_player_position = Vector2 (332, 101)

#########

#########
# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	
	place_name.text = "Path to Objecthia"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	GlobalCanvasModulate.apply_trigger("morning")
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif int(Dialogic.get_variable("gandalf")) == 17:
		Global.set_player_current_position(starting_player_position)
		Hide_controller()
		var new_dialog = Dialogic.start('starter3')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
		#print("gandalf is 17")
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


func path_to_objecthia():
	pass

############## interactions ################
func end_interaction(timelineend):
	show_controller()

func Hide_controller():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()

func show_controller():
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()

func end_intructions(timelineend):
	show_controller()



func first_bug(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "In the code below, what is the correct way to call the GetStrength() method for the warrior object?")
	Global2.set_answers(0, "warrior.GetStrength();")
	Global2.set_answers(1, "GetWarrior();")
	Global2.set_answers(2, "GetStrength();")
	Global2.set_answers(3, "StrengthGet();")
	Global2.set_feedback(0, "Correct! This is the correct way to call the GetStrength() method. Since GetStrength() is a public instance method, you must call it using the object warrior (the instance of the class).")
	Global2.set_feedback(1, "Incorrect. This format is for a static method. Since GetStrength() is an instance method, you need to call it using the object, not pass the object as a parameter.")
	Global2.set_feedback(2, "Incorrect. This is how you would call a static method, but GetStrength() is not static. It belongs to the instance (the warrior object), not the class itself.")
	Global2.set_feedback(3, "Incorrect. This would only work inside the class where GetStrength() is defined. Since you are calling it from outside the class, you need to use the object (warrior) to access the method.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/classess/one.png" )
	
	Global2.set_question(1, "What is the correct way to create an object of the Warrior class?")
	Global2.set_answers(4, "A")
	Global2.set_answers(5, "B")
	Global2.set_answers(6, "C")
	Global2.set_answers(7, "D")
	Global2.set_feedback(4, "A is correct. To create an object of the class Warrior, you need to use the new keyword, which creates an instance of the class.")
	Global2.set_feedback(5, "B only declares a reference but doesn't create the object.")
	Global2.set_feedback(6, "C uses incorrect syntax for object creation.")
	Global2.set_feedback(7, "D uses reversed syntax, which is incorrect.")
	Global2.set_picture_path(1, "res://intro/picture/question/chapter2/classess/stage2-3/1.png")
	
	Global2.set_question(2, "How do you set the strength variable of the Warrior object to 50?")
	Global2.set_answers(8, "A")
	Global2.set_answers(9, "B")
	Global2.set_answers(10, "C")
	Global2.set_answers(11, "D")
	Global2.set_feedback(8, "A lacks the object reference.")
	Global2.set_feedback(9, "B is correct. You access a public variable using objectName.variableName.")
	Global2.set_feedback(10, "C uses pointer syntax, which isn't valid in C#.")
	Global2.set_feedback(11, "D incorrectly uses set, which isn’t required for direct variable access.")
	Global2.set_picture_path(2, "res://intro/picture/question/chapter2/classess/stage2-3/Tanong - 2.png")
	
	Global2.set_question(3, "Which of the following correctly defines a method that returns an integer?")
	Global2.set_answers(12, "A")
	Global2.set_answers(13, "B")
	Global2.set_answers(14, "C")
	Global2.set_answers(15, "D")
	Global2.set_feedback(12, "A and D are incorrect because the return value type does not match the return type in the method signature.")
	Global2.set_feedback(13, "B is correct. The method returns an integer, matching the return type int.")
	Global2.set_feedback(14, "C is incorrect because void indicates the method returns nothing, but it’s trying to return an integer.")
	Global2.set_feedback(15, "A and D are incorrect because the return value type does not match the return type in the method signature.")
	Global2.set_picture_path(3, "res://intro/picture/question/chapter2/classess/stage2-3/Tanong - 3.png")
	
	Global2.set_question(4, "Why does the following code give an error?")
	Global2.set_answers(16, "A")
	Global2.set_answers(17, "B")
	Global2.set_answers(18, "C")
	Global2.set_answers(19, "D")
	Global2.set_feedback(16, "A is incorrect because strength is not static.")
	Global2.set_feedback(17, "B is correct. The variable strength is private and cannot be accessed outside the class directly.")
	Global2.set_feedback(18, "C is incorrect because the error is due to access restrictions, not initialization.")
	Global2.set_feedback(19, "D is incorrect because strength is clearly defined as a variable.")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/classess/stage2-3/Tanong - 4.png")
	
	Global.bug_hide = true
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_1 = true
	Global2.correct_answer_ch3_2 = true
	Global2.correct_answer_ch4_2 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug12"
	print("quiz on bug 2 is activated")
	print(Global.from_level)
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func second_bug(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Why can’t you call the Defend() method directly from outside the Warrior class?")
	Global2.set_answers(0, "A")
	Global2.set_answers(1, "B")
	Global2.set_answers(2, "C")
	Global2.set_answers(3, "D")
	Global2.set_feedback(0, "A is incorrect because strength is not static.")
	Global2.set_feedback(1, "B is correct. The variable strength is private and cannot be accessed outside the class directly.")
	Global2.set_feedback(2, "C is incorrect because the error is due to access restrictions, not initialization.")
	Global2.set_feedback(3, "D is incorrect because strength is clearly defined as a variable.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/classess/stage2-3/Tanong - 5.png")
	
	Global2.set_question(1, "How does a class perceive in C#?")
	Global2.set_answers(4, "Method")
	Global2.set_answers(5, "Variable ")
	Global2.set_answers(6, "Blueprint")
	Global2.set_answers(7, "Loop")
	Global2.set_feedback(4, "Incorrect. A method defines the functionality of a class, not a class blueprint")
	Global2.set_feedback(5, "Incorrect.  A variable holds data, but a class structures objects")
	Global2.set_feedback(6, "Correct! class is a blueprint of an object.")
	Global2.set_feedback(7, "Incorrect. A loop controls repetition, not object creation")
	
	
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
	
	
	Global2.set_question(4, "Which access modifier allows access from outside the class?")
	Global2.set_answers(16, "Private")
	Global2.set_answers(17, "Public")
	Global2.set_answers(18, "Protected")
	Global2.set_answers(19, "Static")
	Global2.set_feedback(16, "Incorrect! Private modifier are prohibits values to be accessible outside the class")
	Global2.set_feedback(17, "Correct. Using public modifiers allows the values of the class to be accessible outside of it.")
	Global2.set_feedback(18, "Incorrect. Protected restricts access to the class and its inheritors.")
	Global2.set_feedback(19, "Incorrect. Static refers to class-level access, not public visibility")
	
	Global.bug_hide = true
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_2 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_1 = true
	Global2.correct_answer_ch4_4 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug13"
	print("quiz on bug 2 is activated")
	print(Global.from_level)
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")
