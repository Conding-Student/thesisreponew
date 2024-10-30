extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2

onready var path_hallway = $objectiaHall_inside/CollisionShape2D
#onready var path_arrow_traning = $YSort/path/path_arrow
var current_map = "res://levels/Chapter2_maps/objectiaOutside.tscn"
var starting_player_position = Vector2 (-7, 128)

#########

#########
# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	path_to_objecthia()
	place_name.text = "Objecthia Outside"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	GlobalCanvasModulate.apply_trigger("noon")
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1 outside")
	elif int(Dialogic.get_variable("gandalf")) == 18:
		Global.set_player_current_position(starting_player_position)
		Hide_controller()
		var new_dialog = Dialogic.start('starter4')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
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
	if Global2.is_badge_complete("badge29"):
		path_hallway.disabled = false
	else:
		path_hallway.disabled = true

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



func slime3(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "What is a Class in C# programming?")
	Global2.set_answers(0, "A")
	Global2.set_answers(1, "B")
	Global2.set_answers(2, "C")
	Global2.set_answers(3, "D")
	Global2.set_feedback(0, "Wrong. A class is not for loops. Loops, like for or while, repeat actions, but a class is a way to define things (like objects).")
	Global2.set_feedback(1, "Right. A class is like a plan or template that helps make objects. It tells what the object can do and what it has.")
	Global2.set_feedback(2, "Wrong. A class can hold functions, but it is not a function. A function is something that runs actions, while a class is the structure that holds those functions.")
	Global2.set_feedback(3, "Wrong. A class is not an array. An array holds multiple values, but a class is used to create objects and describe what they can do.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/classess/stage2-3/New folder/1.png" )
	
	Global2.set_question(1, "What is the purpose of the methods to a class?")
	Global2.set_answers(4, "A")
	Global2.set_answers(5, "B")
	Global2.set_answers(6, "C")
	Global2.set_answers(7, "D")
	Global2.set_feedback(4, "Wrong. Methods don't define attributes (which are like characteristics). Attributes are defined using variables in the class, not methods.")
	Global2.set_feedback(5, "Wrong. A method doesn't create classes. Methods are actions or functions inside a class, while classes themselves are defined separately.")
	Global2.set_feedback(6, "Right. A method is like an action or function that tells the object what it can do, such as 'run' or 'jump.'")
	Global2.set_feedback(7, "Wrong. Methods don't store data. Data is stored in variables or fields in a class. Methods use or change that data by performing actions.")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/classess/stage2-3/New folder/answer - 2.png" )
	
	Global2.set_question(2, "What is the access level of a public variable in C#?")
	Global2.set_answers(8, "A")
	Global2.set_answers(9, "B")
	Global2.set_answers(10, "C")
	Global2.set_answers(11, "D")
	Global2.set_feedback(8, "Wrong. If a variable is marked as public, it can be accessed from outside the class, not just within the class.")
	Global2.set_feedback(9, "Correct . A public variable can be accessed from any part of the program, meaning other classes or parts of the code can use it.")
	Global2.set_feedback(10, "Wrong. This would describe a protected variable, which is only accessible by the class and its child (inherited) classes.")
	Global2.set_feedback(11, "Wrong. This would describe a internal variable, which can be accessed by anything within the same namespace but not outside of it.")
	Global2.set_picture_path(2, "res://intro/picture/question/chapter2/classess/stage2-3/New folder/answer - 3.png")
	
	Global2.set_question(3, "Which of the following access specifiers hides a class member from other classes?")
	Global2.set_answers(12, "A")
	Global2.set_answers(13, "B")
	Global2.set_answers(14, "C")
	Global2.set_answers(15, "D")
	Global2.set_feedback(12, "Wrong. A public class member can be accessed from any other class in the program.")
	Global2.set_feedback(13, "Wrong. A protected member is hidden from other classes, but it can still be accessed by child (inherited) classes.")
	Global2.set_feedback(14, "Correct. A private member is hidden from all other classes and can only be accessed within the class where it's defined.")
	Global2.set_feedback(15, "Wrong. An internal member is hidden from classes outside its namespace, but it can still be accessed by other classes within the same namespace.")
	Global2.set_picture_path(3, "res://intro/picture/question/chapter2/classess/stage2-3/New folder/answer - 4.png")
	
	Global2.set_question(4, "Which keyword is used to create a new object from a class?")
	Global2.set_answers(12, "A")
	Global2.set_answers(13, "B")
	Global2.set_answers(14, "C")
	Global2.set_answers(15, "D")
	Global2.set_feedback(16, "Correct . The new keyword is used to create a new object from a class. It tells the program to make a fresh instance of that class.")
	Global2.set_feedback(17, "Wrong. The class keyword is used to define a class, not to create an object from it.")
	Global2.set_feedback(18, "Wrong. While you are creating an object, the keyword to do so is new, not object.")
	Global2.set_feedback(19, "Wrong. There is no create keyword in C# to make a new object. The correct keyword is new.")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/classess/stage2-3/New folder/answer - 6.png")
	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_2 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_2 = true
	Global2.correct_answer_ch4_3 = true
	Global2.correct_answer_ch5_1 = true
	Global2.dialogue_name = "bug15"
	print("quiz on bug 2 is activated")
	print(Global.from_level)
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")


func slime4(body_rid, body, body_shape_index, local_shape_index):
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
	
	
	Global2.set_question(3, "What does the Main() do?")
	Global2.set_answers(12, "Instance")
	Global2.set_answers(13, "Inheritance")
	Global2.set_answers(14, "Method call")
	Global2.set_answers(15, "Execution start")
	Global2.set_feedback(12, "Incorrect! Instances aren’t created until after Main() starts.")
	Global2.set_feedback(13, "Incorrect. Main() is not related to inheritance, but to program execution.")
	Global2.set_feedback(14, "Incorrect. Main() is not called by other methods but is the entry point.")
	Global2.set_feedback(15, "Correct. It’s where the program starts")
	
	
	Global2.set_question(4, "Why can’t you call the Defend() method directly from outside the Warrior class?")
	Global2.set_answers(16, "A")
	Global2.set_answers(17, "B")
	Global2.set_answers(18, "C")
	Global2.set_answers(19, "D")
	Global2.set_feedback(4, "A is incorrect because strength is not static.")
	Global2.set_feedback(16, "B is correct. The variable strength is private and cannot be accessed outside the class directly.")
	Global2.set_feedback(17, "C is incorrect because the error is due to access restrictions, not initialization.")
	Global2.set_feedback(18, "D is incorrect because strength is clearly defined as a variable.")
	Global2.set_picture_path(4,"res://intro/picture/question/chapter2/classess/stage2-3/Tanong - 5.png")
	
	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_1 = true
	Global2.correct_answer_ch2_1 = true
	Global2.correct_answer_ch3_2 = true
	Global2.correct_answer_ch4_4 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug14"
	print("quiz on bug 2 is activated")
	print(Global.from_level)
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")
