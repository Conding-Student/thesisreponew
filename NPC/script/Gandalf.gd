extends KinematicBody2D

onready var talk_box = $talk_box
onready var interaction_button = $TextureButton
onready var gandalf_collision = $CollisionShape2D
onready var sprite = $Sprite
onready var badges = $badges
signal start_dialogue
signal end_dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Dialogic.get_variable("gandalf"))
	interaction_button.connect("pressed",self, "interaction_start")

func interaction_start():
	interaction_button.hide()
	if int(Dialogic.get_variable("gandalf")) == 0:
		emit_signal("start_dialogue")
		#print("need to debug2")
		var new_dialog = Dialogic.start('c2level1p2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
	elif int(Dialogic.get_variable("gandalf")) == 2:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c2level1_tutorial')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "earn_badge16")
	elif int(Dialogic.get_variable("gandalf")) == 3:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c2level1_tutorial')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
	elif int(Dialogic.get_variable("gandalf")) == 4:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c2stage3p2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
	elif int(Dialogic.get_variable("gandalf")) == 5:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c2stage3p2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
	elif int(Dialogic.get_variable("gandalf")) == 13:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c3stage1p2')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction_anal")
	elif int(Dialogic.get_variable("gandalf")) == 14:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c3stage1p3')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
	elif int(Dialogic.get_variable("gandalf")) == 15 or int(Dialogic.get_variable("gandalf")) == 16:
		emit_signal("start_dialogue")
		var new_dialog = Dialogic.start('c3stage1p4')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")
	else:
		emit_signal("start_dialogue")
		print("default gandalf trigger")
		print(int(Dialogic.get_variable("gandalf")))
		var new_dialog = Dialogic.start('gandalfcatch')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_interaction")

func end_interaction_anal(timelineend):
	emit_signal("end_dialogue")
	SceneTransition.change_scene("res://levels/Chapter2_maps/gandalfHouse_ground.tscn")

func end_interaction(timelineend):
	emit_signal("end_dialogue")

func earn_badge16(timelineend):
	print("badge16 is trigger")
	Global2.complete_badge("badge16")
	SceneTransition.change_scene("res://intro/stages_complete.tscn")
	#badges.update_badges()
	emit_signal("end_dialogue")

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	talk_box.hide()
	interaction_button.show()


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	talk_box.show()
	interaction_button.hide()
