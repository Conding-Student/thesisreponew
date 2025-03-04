extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/Player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/Player
onready var interaction_button = $YSort/child_boy4/interaction_button2
onready var player_control_collision = $YSort/Player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var feedback = $Area2D
onready var feedback_collision = $Area2D/CollisionShape2D
onready var collision_going_outside = $orphanage_outside/CollisionShape2D
var current_map = "res://World/room/orphanage_hallway.tscn"
var staring_player_position = Vector2(301,102)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	place_name.text = "Orphanage Hallway"
	set_overall_initial_position()
	set_player_position()
	feedback.connect("start_dialogue", self, "Hide_controller")
	feedback.connect("end_dialogue", self, "show_controller")
	resume.connect("pressed", self, "resume_the_game")
	interaction_button.connect("pressed",self, "_on_NPC_interaction_stage1")
	Global.set_map(current_map)
	condition_to_feedback()
	
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0,0):
		Global.set_player_current_position(staring_player_position)
		#print("one")
		
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		
	elif Global.from_level != null:
		if Global.door_activated == false && has_node(Global.from_level + "_pos"):
			var target_node = get_node(Global.from_level + "_pos")
			player.global_position = target_node.position
			topui.hide()
			player_controller.hide()
			player_control_collision.disable_joystick()
			var new_dialog = Dialogic.start('heading_tutorial')
			add_child(new_dialog)
			new_dialog.connect("timeline_end", self, "after_tutorial_headings")            
		if has_node(Global.from_level + "_pos"):
			var target_node = get_node(Global.from_level + "_pos")
			player.global_position = target_node.position		
			#print("Player position set from ", Global.from_level + "_pos")
		else:
			pass
			#print(Global.from_level)
			#print("Node with name '%s' does not exist" % (Global.from_level + "_pos"))
	else:
		#print(Global.from_level)
		player.global_position = Global.get_player_current_position()
		#print("five")    

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func after_tutorial_headings(timelinename):
	topui.show()
	player_controller.show()
	player_control_collision.enable_joystick()
	Global.door_activated=true
	

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

func Hide_controller():
	topui.hide()
	player_controller.hide()
	player_control_collision.disable_joystick()

func show_controller():
	topui.show()
	player_controller.show()
	player_control_collision.enable_joystick()

func condition_to_feedback():
	if Global2.is_badge_complete("badge1") == false:
		collision_going_outside.disabled = true
	else:
		feedback_collision.disabled = true
		collision_going_outside.disabled = false

# NPC dialogue enter
	
func _on_NPC_interaction_stage1():
	player_controller.visible = false
	player_control_collision.disable_joystick()
	interaction_button.visible = false
	get_tree().paused = true
	var new_dialog = Dialogic.start('child1')
	new_dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "after_dialog")

func after_dialog(timelinename):
	player_controller.visible = true
	player_control_collision.enable_joystick()
	interaction_button.visible = true
	get_tree().paused = false
	# Remove the dialog from the scene tree
	var dialog = get_child(get_child_count() - 1) # Assuming the dialog is the last added child
	if dialog:
		dialog.queue_free() # This will remove the dialog node
