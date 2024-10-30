extends Area2D

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func stick_to_collision():
	var areas = get_overlapping_areas()
	if is_colliding():
		var area = areas[0]
		# Set the position of the object to match the position of the colliding area
		global_position = area.global_position
