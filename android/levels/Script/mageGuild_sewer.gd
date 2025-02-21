extends Node2D

onready var topui = $TopUi
onready var player_controller = $Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var current_level = $TopUi/Label
onready var player = $Player
onready var player_controls = $Player/Controller
onready var interaction_button = $objects/door/TextureButton

var current_map = "res://levels/stage_3_night/mageGuild_sewer_night.tscn"

var starting_player_position = Vector2 (568, 428)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	
	Global.set_current_level(current_level.text)
	resume.connect("pressed", self, "resume_the_game")
	interaction_button.connect("pressed", self, "first_door")
	Global.set_map(current_map)
	

func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		#print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		#print("2")
	# Whenever the player get into new scene of event.
	elif Global.get_player_current_position() != Vector2(0,0) and Global.player_position_retain == true:
		player.global_position = Global.get_player_current_position()
		
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

func _process(_delta):
	Global.set_player_current_position(player.global_position)
	
func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()

#accesing dialogue
func first_door():
	player_controls.visible = false
	interaction_button.visible = false
	
	Global.set_map(current_map)
	var new_dialog = Dialogic.start('valstage5ep1')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_val")

#dialogue end
func after_val(timelineend):
	pass
