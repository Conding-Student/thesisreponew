extends Area2D

signal start_dialogue
signal end_dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func condition():
	var value = int(Dialogic.get_variable("gandalf"))
	
	match value:
		11:
			#print("you must go back")
			emit_signal("start_dialogue")
			var new_dialog = Dialogic.start('feedback1')
			add_child(new_dialog)
			new_dialog.connect("timeline_end", self, "end_intructions")
		12:
			print("a different message")
		_:
			print("default case if no match")

func condition_badge_base():
	var value = int(Dialogic.get_variable("introduction"))
	var value1 = int(Dialogic.get_variable("feedback"))
	if Global2.is_badge_complete("badge1") == false:
		print("feedback2 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge2") == false && value1 == 0:
		print("feedback2 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback9')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge3") == false && value1 == 1:
		print("feedback4 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback4')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge4") == false:
		print("feedback5 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback5')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge5") == false:
		print("feedback5 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback8')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge6") == true and Global2.is_badge_complete("badge7") == false:
		print("feedback6 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback6')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge7") == true and Global2.is_badge_complete("badge10") == false:
		print("feedback6 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback7' )
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge11") == false and Global2.is_badge_complete("badge12") == false:
		print("feedback5 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge12") == false and Global2.is_badge_complete("badge13") == false:
		print("feedback5 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback6')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif Global2.is_badge_complete("badge13") == false:
		print("feedback5 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	elif value == 0:
		print("feedback3 activated")
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('feedback3')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
	else:
		print("feedback2 in active")

func end_intructions(timelineend):
	emit_signal("end_dialogue")

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Player entered to get feedback")
	condition()
	condition_badge_base()
