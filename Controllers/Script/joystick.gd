extends Area2D

onready var big_circle = $BigCircle
onready var small_circle = $BigCircle/SmallCircle
onready var max_distance = $CollisionShape2D.shape.radius

var touched = false
var joystick_active = true  # This will control whether the joystick can be moved

var active_touch_id = -1  # Track the ID of the active touch controlling the joystick

func _input(event):
	if joystick_active:  # Only allow input when the joystick is active
		if event is InputEventScreenTouch:
			var distance = event.position.distance_to(big_circle.global_position)
			
			if event.is_pressed():
				# Only activate joystick if no other touch is controlling it
				if active_touch_id == -1 and distance < max_distance:
					active_touch_id = event.index
					touched = true
				
				# If this touch controls the joystick, update its position
				if active_touch_id == event.index:
					small_circle.global_position = event.position
					small_circle.position = big_circle.position + (small_circle.position - big_circle.position).limit_length(max_distance)
			else:
				# Reset joystick only if the active touch ends
				if active_touch_id == event.index:
					touched = false
					active_touch_id = -1
					small_circle.position = Vector2(0, 0)


func _process(_delta):
	if joystick_active and touched:  # Only process movement when joystick is active and touched
		# Update small circle position only if still touched
		small_circle.global_position = get_global_mouse_position()
		small_circle.position = big_circle.position + (small_circle.position - big_circle.position).limit_length(max_distance)

func get_velo():
	var joy_velo = Vector2(0, 0)
	if touched and joystick_active:  # Return velocity only when joystick is active and touched
		var relative_position = small_circle.position - big_circle.position
		joy_velo = relative_position.normalized()
	return joy_velo

# Function to disable joystick movement
func disable_joystick():
	joystick_active = false
	touched = false  # Reset touched state to stop joystick movement
	small_circle.position = Vector2(0, 0)  # Reset the small circle's position

# Function to enable joystick movement
func enable_joystick():
	joystick_active = true

func _on_joystick_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	pass  # Replace with function body
