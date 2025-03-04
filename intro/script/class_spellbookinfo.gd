extends TextureRect

onready var class_info = $Control2/class
onready var object_info = $Control2/object
func _on_Create_class_pressed():
	class_info.visible = true
	object_info.visible = false

func _on_create_object_pressed():
	class_info.visible = false
	object_info.visible = true

func _on_close_pressed():
	Global2.resume_trigger_dialogic = false
	hide()
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

func _on_classesreview_pressed():
	helper("c3stage1p3")
