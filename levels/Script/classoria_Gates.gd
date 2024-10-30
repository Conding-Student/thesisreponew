extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var path_to_classoria_main = $classoriaMain/CollisionShape2D
onready var path_to_classoria_main_dialogue = $YSort/dialogue/CollisionShape2D
onready var arrow_head_classoriamain  = $path_arrow_main
onready var path_to_otw = $forest2Chap2/CollisionShape2D
onready var path_arrow_otw = $path_arrow_way
var current_map = "res://levels/Chapter2_maps/classoria_Gates.tscn"
var starting_player_position = Vector2  (160, 33)
var bat_ids_to_check = ["demon1", "demon2","demon3","demon4","demon5","stone1","stone2"] 


# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	
	place_name.text = "Classoria Entrance"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	GlobalCanvasModulate.apply_trigger("night")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")

func _process(delta):
	door_state_classoria_main()
	door_state_otw()

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2 loag game position")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			print("Player position set from ", target_node_path)
		else:
			pass
			print("Player position set from ", target_node_path)
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


func door_state_classoria_main():
	if Global.are_bat_states_false(bat_ids_to_check):
		if int(Dialogic.get_variable("gandalf")) == 10:
			path_to_classoria_main_dialogue.disabled = true
			arrow_head_classoriamain.show()
		else:
			path_to_classoria_main_dialogue.disabled = false
			arrow_head_classoriamain.show()
	else:
		arrow_head_classoriamain.hide()
		path_to_classoria_main.disabled = true
		path_to_classoria_main_dialogue.disabled = true

func door_state_otw():
	if int(Dialogic.get_variable("gandalf")) == 9:
		path_arrow_otw.hide()
		path_to_otw.disabled = true
	else:
		pass
		#print(int(Dialogic.get_variable("gandalf")))
		#print("gandalf value is not equal to 9 to lock the path")
############## interactions ################


func _on_dialogue_body_shape_entered_dialogue(body_rid, body, body_shape_index, local_shape_index):
	player_controller.hide()
	player_controller_joystick.disable_joystick()
	Global.from_level = "forest2Chap2" 
	var new_dialog = Dialogic.start('c2l2stage1p1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")
	new_dialog.connect("dialogic_signal", self, "door_unlocked")

func door_unlocked(param):
	if param == "door_opened":
		path_to_classoria_main_dialogue.disabled = true
		path_to_classoria_main.disabled = false
		Global2.complete_badge("badge21")
		SceneTransition.change_scene("res://intro/stages_complete.tscn")
	else:
		print("error in dialogic siganl")

func end_intructions(timelineend):
	pass
