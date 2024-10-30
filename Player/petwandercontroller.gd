extends Node2D

export(int) var wander_range = 50  # Wander range around the player
export(float) var update_interval = 1.0  # How frequently the pet updates its target

var start_position = Vector2()  # This is where the pet will start its wander calculations, based on player's position
onready var target_position = global_position  # The wander target position
onready var timer = $Timer  # This timer controls the wander update intervals

onready var player = get_parent().get_parent()  # Access the player node from the hierarchy

func _ready():
	update_target_position()  # Initial target
	timer.start(update_interval)  # Start wandering behavior

func update_start_position():
	if player:
		start_position = player.global_position  # Continuously update start_position based on player's current position

func update_target_position():
	update_start_position()  # Ensure the start_position is updated with the player's position
	var random_offset = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + random_offset  # Add random offset to player's position

# Timer timeout: Recalculate target position
func _on_Timer_timeout():
	update_target_position()
	timer.start(update_interval)  # Restart the timer

# Optional: Smoothly move the pet toward the target position (used for gradual movement)
func _process(delta):
	update_start_position()  # Always keep start position updated
