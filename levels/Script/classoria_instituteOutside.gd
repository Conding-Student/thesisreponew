extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var wounded_knight = $YSort/knightst/research_defender
onready var deadknight1 = $YSort/knightst/deathknight/Sprite
onready var deadknight2 = $YSort/knightst/deathknight2/Sprite
var current_map = "res://levels/Chapter2_maps/classoria_instituteOutside.tscn"
var starting_player_position = Vector2  (36, 52)



# Called when the node enters the scene tree for the first time.
func _ready():
	deadknighthliph()
	set_overall_initial_position()
	set_player_position()
	wounded_knight.connect("start_dialogue", self, "Hide_controller")
	wounded_knight.connect("end_dialogue", self, "show_controller")
	place_name.text = "Research Center Front"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	GlobalCanvasModulate.apply_trigger("night")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/deadnight.wav")

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

func deadknighthliph():
	deadknight1.flip_h = true
	deadknight2.flip_h = true

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

func Hide_controller():
	topui.hide()
	player_controller.hide()
	player_controller_joystick.disable_joystick()

func show_controller():
	topui.show()
	player_controller.show()
	player_controller_joystick.enable_joystick()
