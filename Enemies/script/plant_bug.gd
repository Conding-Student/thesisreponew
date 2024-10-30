extends KinematicBody2D


export var slime_id: String = ""  # Unique ID for each bat


# Called when the node enters the scene tree for the first time.
func _ready():
	# Check the state from the Global singleton
	if not Global.get_bat_state(slime_id):
		#print("Bat is dead on load, removing from scene: ID =", bat_id)  # Debugging print
		queue_free()  # If dead, remove from the scene
	else:
		print("plant bug is alive")
