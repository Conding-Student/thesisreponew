extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var gandalf =$YSort/Gandalf 
onready var analexius = $YSort/analexius
onready var otw = $forest2Chap2/CollisionShape2D
onready var path_arrow_traning = $YSort/path/path_arrow
var current_map = "res://levels/Chapter2_maps/gandalfHouse_Outside.tscn"
var starting_player_position = Vector2  (36, 52)

#########
onready var objecthia_dialogue_lock = $YSort/objecthia_path/CollisionShape2D
onready var classoria_dialouge_lock = $YSort/classoria_path/CollisionShape2D
onready var objecthia_path = $objectiaRoad/CollisionShape2D
#########
# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Gandalf house outside"
	resume.connect("pressed", self, "resume_the_game")
	gandalf.connect("start_dialogue",self, "Hide_controller")
	gandalf.connect("end_dialogue", self, "show_controller")
	analexius.connect("start_dialogue",self, "Hide_controller")
	analexius.connect("end_dialogue", self, "show_controller")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
	gandalf_appearance()
	analexius_appearance()
	path_locked_otw()
	morning_setup()
	objecthia_path_trigger()
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
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

func gandalf_appearance():
	if int(Dialogic.get_variable("gandalf")) != 4 or int(Dialogic.get_variable("gandalf")) != 5:
		gandalf.queue_free()
	else:
		print("gandalf is alive")

func analexius_appearance():
	if int(Dialogic.get_variable("gandalf")) != 6:
		analexius.queue_free()
	else:
		print("analexius is alive")

func path_locked_otw():
	if int(Dialogic.get_variable("gandalf")) == 4 or int(Dialogic.get_variable("gandalf")) == 7 or int(Dialogic.get_variable("gandalf")) == 8:
		otw.disabled = false
		path_arrow_traning.visible =true
		classoria_dialouge_lock.disabled = true
	else:
		otw.disabled = true
		path_arrow_traning.visible =false


func morning_setup():
	if int(Dialogic.get_variable("gandalf")) == 4 or int(Dialogic.get_variable("gandalf")) == 5 or int(Dialogic.get_variable("gandalf")) == 6:
		GlobalCanvasModulate.apply_trigger("morning")
	elif int(Dialogic.get_variable("gandalf")) == 7 or int(Dialogic.get_variable("gandalf")) == 8:
		GlobalCanvasModulate.apply_trigger("night")
	else:
		print("dialogic gandalf")

func objecthia_path_trigger():
	
	if Global2.is_badge_complete("badge26"): #if badge 26 has been receive dialogue lock will be disabled and can be pass
		objecthia_path.disabled = false
		objecthia_dialogue_lock.disabled = true
	else:
		objecthia_dialogue_lock.disabled = false
		objecthia_path.disabled = true
############## interactions ################

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
############## interactions ################
func objecthia_lock_path_dialogue(body_rid, body, body_shape_index, local_shape_index):
	Hide_controller()
	var new_dialog = Dialogic.start('pathdialogue')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")


func classoria_path_lock_dialogue(body_rid, body, body_shape_index, local_shape_index):
	Hide_controller()
	var new_dialog = Dialogic.start('pathdialogue')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")
