extends Control

onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_new as Button
onready var continue_button =$MarginContainer/HBoxContainer/VBoxContainer/Continue as Button
onready var badges_button = $MarginContainer/HBoxContainer/VBoxContainer/Badges as Button
onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
onready var settings = $settings2/Panel
onready var quit = $Quit/Panel
onready var ui = $CanvasLayer
onready var badges = $CanvasLayer/badges/Panel4
onready var spell_book = $CanvasLayer/Spell_Book/Panel
onready var save_files = $save_files/Panel
onready var scores = $MarginContainer/HBoxContainer/VBoxContainer/Scores

onready var score_panel = $scores
onready var loaded_files = $save_files/saving_file

func _ready():
	#loaded_files.game_is_done()
	quit.hide()
	settings.hide()
	score_show()
	start_button.connect("pressed", self, "_on_start_pressed")
	exit_button.connect("pressed", self, "_on_exit_pressed")
	continue_button.connect("pressed", self, "_on_continue_pressed")
	loaded_files.check_if_loaded_data()
	
	
	if Global.save_triggered == false:
		continue_button.disabled = true
		
		
		
func score_show():
	var stats = loaded_files.check_finalbadge()
	if Global2.is_badge_complete("badge30") or stats == true:
		scores.show()
		start_button.hide()
		#continue_button.hide()
	else:
		scores.hide()

func _on_continue_pressed() ->void:
	save_files.show()
	Global.load_button_click = true
	

func _on_start_pressed() ->void:
	Global.start_level_trigger = true
	loaded_files.reset_to_default()
	#SceneTransition.change_scene("res://Scenes/intro_chill.tscn")
	SceneTransition.change_scene("res://Scenes/intro_chill.tscn")

func _on_exit_pressed() ->void:
	quit.show()


func _on_settings_pressed():
	settings.show()


func _on_Badges_pressed():
	ui.visible = true
	badges.show()
	
func _on_book_pressed():
	ui.visible = true
	Global2.resume_trigger_dialogic = true
	spell_book.show()


func _on_Scores_pressed():
	score_panel.show()

