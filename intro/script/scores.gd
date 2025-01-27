extends Control

onready var pre_test = $pre_value
onready var post_test = $post_value
onready var nri_value = $NRI_value
onready var saving = $saving_file
onready var prm1 = $prm1
onready var prm2 = $prm2
onready var prm3 = $prm3
onready var prm4 = $prm4
onready var ptm1 = $ptm1
onready var ptm2 = $ptm2
onready var ptm3 = $ptm3
onready var ptm4 = $ptm4
# Called when the node enters the scene tree for the first time.
func _ready():
	saving.game_is_done()
	pre_test.text = str(Global2.pre_final_score)
	post_test.text = str(Global2.post_final_score)
	nri_value.text = str(Global2.NRI)  + "%"
	prm1.text = str(Global2.prm1)
	prm2.text = str(Global2.prm2)
	prm3.text = str(Global2.prm3)
	prm4.text = str(Global2.prm4)
	ptm1.text = str(Global2.ptm1)
	ptm2.text = str(Global2.ptm2)
	ptm3.text = str(Global2.ptm3)
	ptm4.text = str(Global2.ptm4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_close_button_pressed():
	self.hide()
