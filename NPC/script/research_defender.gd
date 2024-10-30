extends KinematicBody2D

onready var interaction_button = $interaction_button

signal start_dialogue
signal end_dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_button.connect("pressed",self, "interaction")


func interaction():
	emit_signal("start_dialogue")
	var new_dialog = Dialogic.start('c2l2stage5')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "end_intructions")

func end_intructions(timelineend):
	interaction_button.hide()
	emit_signal("end_dialogue")



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.show()


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	interaction_button.hide()
