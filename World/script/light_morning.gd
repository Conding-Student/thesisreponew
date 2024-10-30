extends CanvasModulate

var colors = {
	"morning": Color8(141, 163, 153),    # Soft green for morning
	"noon": Color(255, 255, 255),        # Bright white for noon
	"afternoon": Color8(255, 179, 102),  # Warm yellow-orange for afternoon
	"night": Color8(51, 51, 128),        # Dark blue for night
	"evening": Color8(102, 51, 128)      # Evening shade
}

var current_trigger = ""  # Store the current trigger value

# Function to apply a color based on a trigger value
func apply_trigger(trigger_value: String):
	self.color = colors.get(trigger_value, self.color)  # Use existing color if trigger not found
	current_trigger = trigger_value

# Function to reset color to the default (no modulation)
func reset_to_default():
	self.color = Color(1, 1, 1, 1)  # This is the default CanvasModulate color in Godot
	current_trigger = ""

# Function to check the currently applied trigger
func get_current_trigger() -> String:
	return current_trigger
