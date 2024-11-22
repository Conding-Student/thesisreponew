extends Control

onready var pre_test = $pre_value
onready var post_test = $post_value
onready var nri_value = $NRI_value
onready var saving = $saving_file
# Called when the node enters the scene tree for the first time.
func _ready():
	saving.game_is_done()
	pre_test.text = str(Global2.pre_final_score)
	post_test.text = str(Global2.post_final_score)
	nri_value.text = str(Global2.NRI)  + "%"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_close_button_pressed():
	self.hide()
