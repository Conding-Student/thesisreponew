extends Control

signal textbox_closed  # Signal emitted when the textbox is closed
var stats = PlayerStats  # Reference to the player's stats
export(Resource) var enemy = null

onready var enemy_container = $enemy_container

#accesing badges ,label value
onready var badge = $badges
onready var label = $Label
onready var badge_label = $badges/Label
# Questions
onready var question1 = $Question/q1
onready var question2 = $Question/q2
onready var question3 = $Question/q3
onready var question4 = $Question/q4
onready var question5 = $Question/q5

# Choices and panel
onready var ch1_panel = $action_panel/choices1
onready var ch1_1 = $action_panel/choices1/ch1_1
onready var ch1_2 = $action_panel/choices1/ch1_2
onready var ch1_3 = $action_panel/choices1/ch1_3
onready var ch1_4 = $action_panel/choices1/ch1_4

onready var ch2_panel = $action_panel/choices2
onready var ch2_1 = $action_panel/choices2/ch2_1
onready var ch2_2 = $action_panel/choices2/ch2_2
onready var ch2_3 = $action_panel/choices2/ch2_3
onready var ch2_4 = $action_panel/choices2/ch2_4

onready var ch3_panel = $action_panel/choices3
onready var ch3_1 = $action_panel/choices3/ch3_1
onready var ch3_2 = $action_panel/choices3/ch3_2
onready var ch3_3 = $action_panel/choices3/ch3_3
onready var ch3_4 = $action_panel/choices3/ch3_4

onready var ch4_panel = $action_panel/choices4
onready var ch4_1 = $action_panel/choices4/ch4_1
onready var ch4_2 = $action_panel/choices4/ch4_2
onready var ch4_3 = $action_panel/choices4/ch4_3
onready var ch4_4 = $action_panel/choices4/ch4_4

onready var ch5_panel = $action_panel/choices5
onready var ch5_1 = $action_panel/choices5/ch5_1
onready var ch5_2 = $action_panel/choices5/ch5_2
onready var ch5_3 = $action_panel/choices5/ch5_3
onready var ch5_4 = $action_panel/choices5/ch5_4

#background pic
onready var bg_pic1 = $bg_pic1
onready var bg_pic2 = $bg_pic2
onready var bg_pic3 = $bg_pic3
onready var bg_pic4 = $bg_pic4
onready var bg_pic5 = $bg_pic5

# Player
onready var hurt = $hurt

signal no_health  # Signal emitted when player health reaches zero

# Textbox panel
onready var feedback_panel = $textbox
onready var feedback_label = $textbox/Label

#enemy
onready var enemy_picture = $enemy_container/bat
onready var enemy_health_bar = $enemy_container/ProgressBar
onready var animation_player = $AnimationPlayer
onready var enemy_hit = $hit
onready var enemy_die = $enemy_die
var current_enemy_health = 0

func hiding_enemy_ui():
	if Global.bug_hide == true:
		enemy_container.hide()
	else:
		enemy_container.show()

# Function to set the current health, max health, and texture
func set_health(health, max_health, picture):
	enemy_health_bar.max_value = max_health  # Set max health
	enemy_health_bar.value = health  # Set current health
	enemy_health_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]  # Update label
	enemy_picture.texture = picture  # Set the picture (TextureRect)
	#print("Health after setting: ", health, " / ", max_health)  # Debugging print

# Function to deal damage and update health
func deal_damage(damage_amount):
	enemy_hit.play() #playing sounds when hit the enemy
	#print("Damage dealt: ", damage_amount)  # Debugging print
	# Reduce health by damage dealt, ensuring it doesn't go below 0
	current_enemy_health = max(0, current_enemy_health - damage_amount)
	#print("Health after damage: ", current_enemy_health)  # Debugging print
   # Update the health in the UI
	set_health(current_enemy_health, Global2.enemy_data.health, Global2.enemy_data.texture)
	# Check if the enemy is dead
	if current_enemy_health <= 0:
		#print("Enemy is dead!")
		animation_player.play("health_hide")
		animation_player.play("enemy_damage")
# Called when the node is added to the scene
func _ready():
	GlobalCanvasModulate.reset_to_default()
	hiding_enemy_ui()
	badge_label.hide()
	# Ensure that enemy data is loaded
	if Global2.enemy_data != null:
		# Set initial health from the enemy data
		current_enemy_health = Global2.enemy_data.health
		#
		print("Initial health set to: ", current_enemy_health)  # Debugging print
		# Set the health, max health, and texture in the UI
		set_health(current_enemy_health, Global2.enemy_data.health, Global2.enemy_data.texture)
	else:
		print("No enemy data loaded.")
	# Set up the first question and answers if available
	if Global2.get_question(0) != "" && Global2.get_answers(0) != "" && Global2.get_answers(1) != "" && Global2.get_answers(2) != "" && Global2.get_answers(3) != "":
		question1.text = Global2.get_question(0)
		ch1_1.text = Global2.get_answers(0)
		ch1_2.text = Global2.get_answers(1)
		ch1_3.text = Global2.get_answers(2)
		ch1_4.text = Global2.get_answers(3)
		bg_pic1.texture = load(Global2.get_picture_path(0))
		
	else:
		pass

	# Set up the second question and answers if available
	if Global2.get_question(1) != "" && Global2.get_answers(4) != "" && Global2.get_answers(5) != "" && Global2.get_answers(6) != "" && Global2.get_answers(7) != "":
		question2.text = Global2.get_question(1)
		ch2_1.text = Global2.get_answers(4)
		ch2_2.text = Global2.get_answers(5)
		ch2_3.text = Global2.get_answers(6)
		ch2_4.text = Global2.get_answers(7)
		bg_pic2.texture = load(Global2.get_picture_path(1))
	else:
		#print("feedback 2 trigger")
		Global2.change_scene_on_question1 = true
	
	# Set up the third question and answers if available
	if Global2.get_question(2) != "" && Global2.get_answers(8) != "" && Global2.get_answers(9) != "" && Global2.get_answers(10) != "" && Global2.get_answers(11) != "":
		question3.text = Global2.get_question(2)
		ch3_1.text = Global2.get_answers(8)
		ch3_2.text = Global2.get_answers(9)
		ch3_3.text = Global2.get_answers(10)
		ch3_4.text = Global2.get_answers(11)
		bg_pic3.texture = load(Global2.get_picture_path(2))
	else:
		#print("feedback 3 trigger")
		Global2.change_scene_on_question2 = true

	# Set up the fourth question and answers if available
	if Global2.get_question(3) != "" && Global2.get_answers(12) != "" && Global2.get_answers(13) != "" && Global2.get_answers(14) != "" && Global2.get_answers(15) != "":
		question4.text = Global2.get_question(3)
		ch4_1.text = Global2.get_answers(12)
		ch4_2.text = Global2.get_answers(13)
		ch4_3.text = Global2.get_answers(14)
		ch4_4.text = Global2.get_answers(15)
		bg_pic4.texture = load(Global2.get_picture_path(3))
	else:
		#print("feedback 4 trigger")
		Global2.change_scene_on_question3 = true
	
	# Set up the fifth question and answers if available
	if Global2.get_question(4) != "" && Global2.get_answers(16) != "" && Global2.get_answers(17) != "" && Global2.get_answers(18) != "" && Global2.get_answers(19) != "":
		question5.text = Global2.get_question(4)
		ch5_1.text = Global2.get_answers(16)
		ch5_2.text = Global2.get_answers(17)
		ch5_3.text = Global2.get_answers(18)
		ch5_4.text = Global2.get_answers(19)
		bg_pic5.texture = load(Global2.get_picture_path(4))
	else:
		#print("feedback 5 trigger")
		Global2.change_scene_on_question4 = true
	
	# Set up the six question and answers if available
	if Global2.get_question(5) != "" && Global2.get_answers(20) != "":
		pass
		#print("feedback 6 trigger null")
	else:
		#print("feedback 6 trigger")
		Global2.change_scene_on_question0 = true
	
	stats.connect("no_health", self, "_on_no_health")  # Connect the no_health signal
	q_and_a_show()  # Show the question and answer panel initially

# Show the question and answer panel
func q_and_a_show():
	$action_panel.show()
	$Question.show()

# Hide the question and answer panel
func q_and_a_hide():
	$action_panel.hide()
	$Question.hide()

# Handle screen touch input to hide the textbox and emit the textbox_closed signal
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		$textbox.hide()
		emit_signal("textbox_closed")

# Handle the player's no_health signal
func _on_no_health():
	stats.health = 5  # Reset player's health
	var result = get_tree().change_scene("res://intro/Game_over.tscn")  # Change to Game Over scene
	if result != OK:
		print("failed to load " + result) 

# Display text in the textbox
func display_text(text):
	$textbox.show()
	$textbox/Label.text = text

# Display enemy dialogue sequence
func enemy_dialogue(feedback):
	q_and_a_hide()  # Hide Q&A panel
	display_text(feedback)
	yield(self, "textbox_closed")
	$AnimationPlayer.play("shake")
	hurt.play()
	yield($AnimationPlayer, "animation_finished")
	
	stats.health = max(0, stats.health - 1)  # Decrease player health and play the shake animation
	
	q_and_a_show()  # Show Q&A panel again

# Handle feedback after an answer, with the option to change the scene
func feedback(feedback, change_scene_on, dialogue_name):
	q_and_a_hide()  # Hide Q&A panel
	display_text(feedback)
	yield(self, "textbox_closed")
	need_hearts(change_scene_on, dialogue_name)

# Original feedback function (no scene change)
func feedback_orig(feedback):
	display_text(feedback)
	yield(self, "textbox_closed")

# Check if the player needs more health (hearts)
func need_hearts(change_scene_on, dialogue_name):
	if stats.health == 5:
		stats.health = max(0, stats.health + 0)  # Player health is full, no change
		display_text("No need to gain hearts")
		yield(self, "textbox_closed")
		change_scene(change_scene_on, dialogue_name)
	else:
		stats.health = max(0, stats.health + 1)  # Increase player health by 1
		display_text("You will gain 1 heart")
		yield(self, "textbox_closed")
		change_scene(change_scene_on, dialogue_name)
		q_and_a_show()

# Change the scene based on a condition
func change_scene(change_scene_on, dialogue_name):
	if Global2.get(change_scene_on) == true:
		var new_dialog = Dialogic.start(dialogue_name)
		add_child(new_dialog)
		new_dialog.connect("dialogic_signal", self, "value_activating")
		new_dialog.connect("timeline_end", self, "end")
	else:
		q_and_a_show()

func end(timelineend):
	Global.bug_hide = false

func value_activating(param):
	print("value activing")
	if param == "bug2":
		print("badge receive 17")
		Global.set_bat_state("bug2", false) 
		var bat_ids_to_check = ["bug1", "bug2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified bat states are false.")
			Global2.completed_badge("badge17")
			
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			#print("Some specified bat states are true.")
			
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	elif param == "bug1":
		print("badge receive 17")
		Global.set_bat_state("bug1", false) 
		var bat_ids_to_check = ["bug1", "bug2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified bat states are false.")
			Global2.complete_badge("badge17")
			
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	else:
		print("value in dialogic gas not yet been triggered")
	
	if param == "slime2":
		print("badge receive 20")
		Global.set_bat_state("slime2", false) 
		var bat_ids_to_check = ["slime1", "slime2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Dialogic.set_variable("gandalf", 8)
			Global2.complete_badge("badge20")
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			Global2.complete_badge("badge19")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	
	if param == "slime1":
		print("badge receive 20")
		Global.set_bat_state("slime1", false) 
		var bat_ids_to_check = ["slime1", "slime2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Global2.complete_badge("badge20")
			Dialogic.set_variable("gandalf", 8)
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			Global2.complete_badge("badge19")
			#print("this one activitingslime 2 di bukas")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	
	if param == "bug6":
		print("badge receive 22")
		Global.set_bat_state("bug4", false) 
		var bat_ids_to_check = ["bug3", "bug4"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Global2.complete_badge("badge22")
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			#print("this one activitingslime 2 di bukas")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	if param == "badge22":
		print("badge receive 22")
		Global.set_bat_state("bug3", false) 
		var bat_ids_to_check = ["bug3", "bug4"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Global2.complete_badge("badge22")
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			#print("this one activitingslime 2 di bukas")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	if param == "badge23":
		print("badge receive 23")
		Global.set_bat_state("slime3", false) 
		Global2.complete_badge("badge23")
		SceneTransition.change_scene("res://intro/stages_complete.tscn")
	if param == "badge24":
		print("badge receive 24")
		Global.set_bat_state("slime4", false) 
		Global2.complete_badge("badge24")
		SceneTransition.change_scene("res://intro/stages_complete.tscn")
	############# chapter 3 ###################
	if param == "bug5":
		print("chapter 3 badge 1")
		Global.set_bat_state("kalaban1", false) 
		var bat_ids_to_check = ["kalaban1", "kalaban2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Dialogic.set_variable("gandalf", 17)
			Global2.complete_badge("badge26") #### on
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			Global2.complete_badge("badge26")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	if param == "bug6.1":
		print("chapter 3 badge 1")
		Global.set_bat_state("kalaban2", false) 
		var bat_ids_to_check = ["kalaban1", "kalaban2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Dialogic.set_variable("gandalf", 17)
			Global2.complete_badge("badge26") #### on
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			Global2.complete_badge("badge26")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	
	if param == "badge28":
		print("badge receive 28")
		Global.set_bat_state("plantbug2", false) 
		var bat_ids_to_check = ["plantbug1", "plantbug2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Dialogic.set_variable("gandalf", 18)
			Global2.complete_badge("badge28")
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			Global2.complete_badge("badge27")
			Dialogic.set_variable("gandalf", 18)
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	
	if param == "badge27":
		print("badge receive 27")
		Global.set_bat_state("plantbug1", false) 
		var bat_ids_to_check = ["plantbug1", "plantbug2"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Global2.complete_badge("badge28")
			Dialogic.set_variable("gandalf", 18)
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			Global2.complete_badge("badge27")
			Dialogic.set_variable("gandalf", 18)
			#print("this one activitingslime 2 di bukas")
			SceneTransition.change_scene("res://intro/evaluation.tscn")

	if param == "slime4":
		print("slime 4")
		Global.set_bat_state("slime4", false) 
		var bat_ids_to_check = ["slime4", "slime3"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Global2.complete_badge("badge29")
			#Dialogic.set_variable("gandalf", 18)
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			#print("this one activitingslime 2 di bukas")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
		
	if param == "slime3":
		print("slime 3")
		Global.set_bat_state("slime3", false) 
		var bat_ids_to_check = ["slime4", "slime3"] #check if they are both existed
		if Global.are_bat_states_false(bat_ids_to_check):
			#print("All specified slime states are false.")
			Global2.complete_badge("badge29")
			#Dialogic.set_variable("gandalf", 18)
			SceneTransition.change_scene("res://intro/stages_complete.tscn")
		else:
			#print("this one activitingslime 2 di bukas")
			SceneTransition.change_scene("res://intro/evaluation.tscn")
	############################################
# Reset all relevant Global2 properties to false (used to avoid dialogue errors)

	#Global2.reset_trigger_answers()
# Show the second question, hide others
func question2_show():
	question1.visible = false
	question2.visible = true
	question3.visible = false
	question4.visible = false
	question5.visible = false
	bg_pic1.visible = false
	bg_pic2.visible = true
	bg_pic3.visible = false
	bg_pic4.visible = false
	bg_pic5.visible = false

# Show the third question, hide others
func question3_show():
	question1.visible = false
	question2.visible = false
	question3.visible = true
	question4.visible = false
	question5.visible = false
	bg_pic1.visible = false
	bg_pic2.visible = false
	bg_pic3.visible = true
	bg_pic4.visible = false
	bg_pic5.visible = false

# Show the third question, hide others
func question4_show():
	question1.visible = false
	question2.visible = false
	question3.visible = false
	question4.visible = true
	question5.visible = false
	bg_pic1.visible = false
	bg_pic2.visible = false
	bg_pic3.visible = false
	bg_pic4.visible = true
	bg_pic5.visible = false

# Show the third question, hide others
func question5_show():
	question1.visible = false
	question2.visible = false
	question3.visible = false
	question4.visible = false
	question5.visible = true
	bg_pic1.visible = false
	bg_pic2.visible = false
	bg_pic3.visible = false
	bg_pic4.visible = false
	bg_pic5.visible = true

# Handle the action when the first choice of the first question is pressed
func _on_ch1_1_pressed():
	if Global2.correct_answer_ch1_1 == true:
		deal_damage(1)
		question2_show()
		ch1_panel.visible = false
		ch2_panel.visible = true
		Global2.set_trigger_answer(0,0, true)
		feedback(Global2.get_feedback(0), "change_scene_on_question1", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(0))
		Global2.set_trigger_answer(0,0, true)
	
# Handle the action when the second choice of the first question is pressed
func _on_ch1_2_pressed():
	if Global2.correct_answer_ch1_2 == true:
		deal_damage(1)
		question2_show()
		ch1_panel.visible = false
		ch2_panel.visible = true
		Global2.set_trigger_answer(0,1, true)	
		feedback(Global2.get_feedback(1), "change_scene_on_question1", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(1))
		Global2.set_trigger_answer(0,1, true)

# Handle the action when the third choice of the first question is pressed
func _on_ch1_3_pressed():
	if Global2.correct_answer_ch1_3 == true:
		deal_damage(1)
		question2_show()
		ch1_panel.visible = false
		ch2_panel.visible = true
		Global2.set_trigger_answer(0,2, true)
		feedback(Global2.get_feedback(2), "change_scene_on_question1", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(2))
		Global2.set_trigger_answer(0,2, true)

# Handle the action when the fourth choice of the first question is pressed
func _on_ch1_4_pressed():
	if Global2.correct_answer_ch1_4 == true:
		deal_damage(1)
		question2_show()
		ch1_panel.visible = false
		ch2_panel.visible = true
		Global2.set_trigger_answer(0,3, true)
		feedback(Global2.get_feedback(3), "change_scene_on_question1", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(3))
		Global2.set_trigger_answer(0,3, true)

# Handle the action when the first choice of the second question is pressed
func _on_ch2_1_pressed():
	if Global2.correct_answer_ch2_1 == true:
		deal_damage(1)
		question3_show()
		ch2_panel.visible = false
		ch3_panel.visible = true
		Global2.set_trigger_answer(1,0, true)
		feedback(Global2.get_feedback(4), "change_scene_on_question2", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(4))
		Global2.set_trigger_answer(1,0, true)

# Handle the action when the second choice of the second question is pressed
func _on_ch2_2_pressed():
	if Global2.correct_answer_ch2_2 == true:
		deal_damage(1)
		question3_show()
		ch2_panel.visible = false
		ch3_panel.visible = true
		Global2.set_trigger_answer(1,1, true)
		feedback(Global2.get_feedback(5), "change_scene_on_question2", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(5))
		Global2.set_trigger_answer(1,1, true)

# Handle the action when the third choice of the second question is pressed
func _on_ch2_3_pressed():
	if Global2.correct_answer_ch2_3 == true:
		deal_damage(1)
		question3_show()
		ch2_panel.visible = false
		ch3_panel.visible = true
		Global2.set_trigger_answer(1,2, true)
		feedback(Global2.get_feedback(6), "change_scene_on_question2", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(6))
		Global2.set_trigger_answer(1,2, true)

# Handle the action when the fourth choice of the second question is pressed
func _on_ch2_4_pressed():
	if Global2.correct_answer_ch2_4 == true:
		deal_damage(1)
		question3_show()
		ch2_panel.visible = false
		ch3_panel.visible = true
		Global2.set_trigger_answer(1,3, true)
		feedback(Global2.get_feedback(7), "change_scene_on_question2", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(7))
		Global2.set_trigger_answer(1,3, true)


func _on_ch3_1_pressed():
	if Global2.correct_answer_ch3_1 == true:
		deal_damage(1)
		question4_show()
		ch3_panel.visible = false
		ch4_panel.visible = true
		Global2.set_trigger_answer(2,0, true)
		feedback(Global2.get_feedback(8), "change_scene_on_question3", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(8))
		Global2.set_trigger_answer(2,0, true)
		


func _on_ch3_2_pressed():
	if Global2.correct_answer_ch3_2 == true:
		deal_damage(1)
		question4_show()
		ch3_panel.visible = false
		ch4_panel.visible = true
		Global2.set_trigger_answer(2,1, true)
		feedback(Global2.get_feedback(9), "change_scene_on_question3", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(9))
		Global2.set_trigger_answer(2,1, true)


func _on_ch3_3_pressed():
	if Global2.correct_answer_ch3_3 == true:
		deal_damage(1)
		question4_show()
		ch3_panel.visible = false
		ch4_panel.visible = true
		Global2.set_trigger_answer(2,2, true)
		feedback(Global2.get_feedback(10), "change_scene_on_question3", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(10))
		Global2.set_trigger_answer(2,2, true)


func _on_ch3_4_pressed():
	if Global2.correct_answer_ch3_4 == true:
		deal_damage(1)
		question4_show()
		ch3_panel.visible = false
		ch4_panel.visible = true
		Global2.set_trigger_answer(2,3, true)
		feedback(Global2.get_feedback(11), "change_scene_on_question3", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(11))
		Global2.set_trigger_answer(2,3, true)


func _on_ch4_1_pressed():
	if Global2.correct_answer_ch4_1 == true:
		deal_damage(1)
		question5_show()
		ch4_panel.visible = false
		ch5_panel.visible = true
		Global2.set_trigger_answer(3,0, true)
		feedback(Global2.get_feedback(12), "change_scene_on_question4", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(12))
		Global2.set_trigger_answer(3,0, true)


func _on_ch4_2_pressed():
	if Global2.correct_answer_ch4_2 == true:
		deal_damage(1)
		question5_show()
		ch4_panel.visible = false
		ch5_panel.visible = true
		Global2.set_trigger_answer(3,1, true)
		feedback(Global2.get_feedback(13), "change_scene_on_question4", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(13))
		Global2.set_trigger_answer(3,1, true)


func _on_ch4_3_pressed():
	if Global2.correct_answer_ch4_3 == true:
		deal_damage(1)
		question5_show()
		ch4_panel.visible = false
		ch5_panel.visible = true
		Global2.set_trigger_answer(3,2, true)
		feedback(Global2.get_feedback(14), "change_scene_on_question4", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(14))
		Global2.set_trigger_answer(3,2, true)


func _on_ch4_4_pressed():
	if Global2.correct_answer_ch4_4 == true:
		deal_damage(1)
		question5_show()
		ch4_panel.visible = false
		ch5_panel.visible = true
		Global2.set_trigger_answer(3,3, true)
		feedback(Global2.get_feedback(15), "change_scene_on_question4", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(15))
		Global2.set_trigger_answer(3,3, true)


func _on_ch5_1_pressed():
	if Global2.correct_answer_ch5_1 == true:
		deal_damage(1)
		question5_show()
		ch5_panel.visible = false
		Global2.set_trigger_answer(4,0, true)
		#print(Global2.change_scene_on_question0)
		feedback(Global2.get_feedback(16), "change_scene_on_question0", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(16))
		Global2.set_trigger_answer(4,0, true)
		#print("else"+ str(Global2.change_scene_on_question0))

func _on_ch5_2_pressed():
	if Global2.correct_answer_ch5_2 == true:
		deal_damage(1)
		question5_show()
		#print(Global2.change_scene_on_question0)
		ch5_panel.visible = false
		Global2.set_trigger_answer(4,1, true)
		#print(Global2.change_scene_on_question0)
		feedback(Global2.get_feedback(17), "change_scene_on_question0", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(17))
		Global2.set_trigger_answer(4,1, true)
		#print("else"+ str(Global2.change_scene_on_question0))

func _on_ch5_3_pressed():
	if Global2.correct_answer_ch5_3 == true:
		deal_damage(1)
		question5_show()
		ch5_panel.visible = false
		Global2.set_trigger_answer(4,2, true)
		#print(Global2.change_scene_on_question0)
		feedback(Global2.get_feedback(18), "change_scene_on_question0", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(18))
		Global2.set_trigger_answer(4,2, true)
		#print("else"+ str(Global2.change_scene_on_question0))


func _on_ch5_4_pressed():
	if Global2.correct_answer_ch5_4 == true:
		deal_damage(1)
		question5_show()
		Global2.set_trigger_answer(4,3, true)
		#print(Global2.change_scene_on_question0)
		feedback(Global2.get_feedback(19), "change_scene_on_question0", Global2.dialogue_name)
	else:
		animation_player.play("shake")
		enemy_dialogue(Global2.get_feedback(19))
		Global2.set_trigger_answer(4,3, true)
		#print("else"+ str(Global2.change_scene_on_question0))
