extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var bug_king = $YSort/enemy/rat_king2
onready var rat_king = $YSort/enemy/rat_king
onready var logical_bugking = $YSort/enemy/bug_king

onready var bugcollision = $YSort/enemy/bug_king/Hitbox/CollisionShape2D
onready var logic_bug_heart = $YSort/enemy/bug_king/Stats
#onready var path_arrow_traning = $YSort/path/path_arrow
var current_map = "res://levels/Chapter2_maps/objectiaHall_inside.tscn"
var starting_player_position = Vector2  (222, 265)

#########

#########
# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	bug_king_appearance()
	enemy_wave1()
	place_name.text = "Objecthia Hall"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	GlobalCanvasModulate.apply_trigger("noon")
func _process(delta):
	bug_king_checking_heart()

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1 outside")
	elif int(Dialogic.get_variable("gandalf")) == 19:
		player.global_position = starting_player_position
		Global.set_player_current_position(starting_player_position)
		Hide_controller()
		var new_dialog = Dialogic.start('c3stage5p2')
		add_child(new_dialog)
		new_dialog.connect("dialogic_signal", self, "value_activating")
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
		#bug_king.queue_free()
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
	#get_tree().paused = false
	print("timeline end trigger")
	#bug_king.queue_free()

func bug_king_appearance():
	if int(Dialogic.get_variable("gandalf")) == 20:
		bug_king.queue_free()
	elif int(Dialogic.get_variable("gandalf")) == 21:
		bug_king.queue_free()
	elif int(Dialogic.get_variable("gandalf")) == 22:
		bug_king.queue_free()
		rat_king.queue_free()
	else:
		print("he is alive")

func bug_king_checking_heart():
	if logic_bug_heart.health == 1:
		Global2.set_question(0, "Begin your attack into the enemy by defining a class. Create a class using 'class' keyword")
		Global2.set_answers(0, "class")
		Global2.set_feedback(0, "The answer should be 'class' check for any white spaces if your wrong")
		#Global2.set_picture_path()
		
		Global2.set_question(1, "Put name into your class, this time name it as a 'Person' check for any white spaces if your wrong")
		Global2.set_answers(1, "Person")
		Global2.set_feedback(1, "The answer should be 'Person'")
		#Global2.set_picture_path()
		
		Global2.set_question(2, "Put curly braces at your class person")
		Global2.set_answers(2, "{}")
		Global2.set_feedback(2, "You should put two curly braces from it, check for any white spaces if your still wrong")
		#Global2.set_picture_path()
		
		Global2.set_question(3, "This class person must have a name! declare public fields string and named it as 'name'")
		Global2.set_answers(3, "public string name;")
		Global2.set_feedback(3, "The answer should be 'public string name;' check for semi-colon, spelling and whitespaces if you're still wrong")
		#Global2.set_picture_path()
		
		Global2.set_question(4, "Do it again but make its datatype as an 'int' and named it as an 'age'")
		Global2.set_answers(4, "public int age;")
		Global2.set_feedback(4, "The answer should be 'public int age;' check for semi-colon, spelling and whitespaces if you're still wrong")
		#Global2.set_picture_path()
		
		Global2.dialogue_name = "bug17"
		Hide_controller()
		get_tree().paused = true
		#bugcollision.disabled = true
		var new_dialog = Dialogic.start('c3stage5p4')
		new_dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")

func enemy_wave1():
	if int(Dialogic.get_variable("gandalf")) == 20: 
		$YSort/enemy/stone10.queue_free()
		$YSort/enemy/stone11.queue_free()
		$YSort/enemy/blue5.queue_free()
		$YSort/enemy/blue6.queue_free()
		$YSort/enemy/blue7.queue_free()
		$YSort/enemy/blue8.queue_free()
	elif int(Dialogic.get_variable("gandalf")) == 22:
		#pass
		print("letting them all live")
	else:
		print("else and killing all enemies")
		$YSort/enemy/snake1.queue_free()
		$YSort/enemy/snake2.queue_free()
		$YSort/enemy/snake3.queue_free()
		$YSort/enemy/snake4.queue_free()
		$YSort/enemy/snake5.queue_free()
		$YSort/enemy/snake6.queue_free()
		$YSort/enemy/snake7.queue_free()
		$YSort/enemy/snake8.queue_free()
		$YSort/enemy/snake9.queue_free()
		$YSort/enemy/snake10.queue_free()
		$YSort/enemy/snake11.queue_free()
		$YSort/enemy/snake12.queue_free()
		$YSort/enemy/stone8.queue_free()
		$YSort/enemy/stone9.queue_free()
		$YSort/enemy/stone10.queue_free()
		$YSort/enemy/stone11.queue_free()
		$YSort/enemy/blue5.queue_free()
		$YSort/enemy/blue6.queue_free()
		$YSort/enemy/blue7.queue_free()
		$YSort/enemy/blue8.queue_free()



func rat_king(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Begin your attack into the enemy by defining a class. Create a class using 'class' keyword")
	Global2.set_answers(0, "class")
	Global2.set_feedback(0, "The answer should be 'class' check for any white spaces if your wrong")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/classess/stag5/first/Oct 21 - 1.png")
	
	Global2.set_question(1, "Put name into your class, this time name it as a 'Person' check for any white spaces if your wrong")
	Global2.set_answers(1, "Person")
	Global2.set_feedback(1, "The answer should be 'Person'")
	Global2.set_picture_path(1,"res://intro/picture/question/chapter2/classess/stag5/first/Oct 21 - 2.png" )
	
	Global2.set_question(2, "Put curly braces at your class person")
	Global2.set_answers(2, "{}")
	Global2.set_feedback(2, "You should put two curly braces from it, check for any white spaces if your still wrong")
	Global2.set_picture_path(2, "res://intro/picture/question/chapter2/classess/stag5/first/Oct 21 - 3.png")
	
	Global2.set_question(3, "This class person must have a name! declare public fields string and named it as 'name'")
	Global2.set_answers(3, "public string name;")
	Global2.set_feedback(3, "The answer should be 'public string name;' check for semi-colon, spelling and whitespaces if you're still wrong")
	Global2.set_picture_path(3, "res://intro/picture/question/chapter2/classess/stag5/first/Oct 21 - 4.png")
	
	Global2.set_question(4, "Do it again but make its datatype as an 'int' and named it as an 'age'")
	Global2.set_answers(4, "public int age;")
	Global2.set_feedback(4, "The answer should be 'public int age;' check for semi-colon, spelling and whitespaces if you're still wrong")
	Global2.set_picture_path(4, "res://intro/picture/question/chapter2/classess/stag5/first/Oct 21 - 5.png")
	
	Global2.dialogue_name = "bug16"
	Hide_controller()
	var new_dialog = Dialogic.start('c3stage5p3')
	add_child(new_dialog)
	new_dialog.connect("dialogic_signal", self, "value_activating")
	new_dialog.connect("timeline_end", self, "end_interaction")
	
