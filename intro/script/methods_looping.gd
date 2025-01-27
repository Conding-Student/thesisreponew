extends Node

onready var panel = $Panel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func end_instructions(timelineend):
	if Global2.resume_trigger_dialogic == true:
		# Safely remove the dialog from the scene tree
		for child in get_tree().root.get_children():
			if child.name == "DialogicNode":  # Check for the dialog node
				child.queue_free()
		print("Dialog finished and cleaned up menu.")
	else:
		for child in get_parent().get_children():
			if child.name == "DialogicNode":  # Check for the dialog node
				child.queue_free()
		print("Dialog finished and cleaned up in game.")

func _on_close_pressed():
	Global2.resume_trigger_dialogic = false
	panel.hide()

func helper(text):
	if Global2.resume_trigger_dialogic == true:
		print("true trigger")
		var new_dialog = Dialogic.start(text)
		get_tree().root.add_child(new_dialog)  # Adds to the root viewport
		new_dialog.connect("timeline_end", self, "end_instructions")
	else:
		print("false trigger")
		var canvas_layer2 = get_parent()
		# Step 2: Start the Dialogic dialog
		var new_dialog = Dialogic.start(text)
		# Step 3: Add the dialog to CanvasLayer2
		canvas_layer2.add_child(new_dialog)
		# Step 4: Connect the timeline_end signal
		new_dialog.connect("timeline_end", self, "end_instructions")


func _on_while_pressed():
	helper("whileloop")

func _on_dowhile_pressed():
	helper("dowhile")

func _on_for_pressed():
	helper("forloop")
