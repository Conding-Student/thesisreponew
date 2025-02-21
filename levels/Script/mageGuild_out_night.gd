extends Node2D

onready var topui = $TopUi
onready var player_controller = $objects/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $objects/Player
onready var player_controls = $objects/Player/Controller
onready var place_name = $TopUi/Label2
var current_map = "res://levels/stage_3_night/mageGuild_out_night.tscn"
var starting_player_position = Vector2 (568, 428)
var dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	
	place_name.text = "Mage Guild Outside"
	resume.connect("pressed", self, "resume_the_game")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildOutside_night.wav")
	Musicmanager.change_scene("Mage Guild Outside night")
	Global.set_map(current_map)

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
			#print(Global.get_player_current_position())
		else:
			pass
			#print("Player position set from ", target_node_path)
	else:
		player.global_position = Global.get_player_current_position()
		#print("3")

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
