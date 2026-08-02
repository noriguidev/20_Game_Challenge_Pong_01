extends RigidBody2D

@export var speed = 700;

func _integrate_forces(state):
	# Get a negative(up) and a positive(down) axis from a keybind to determine the direction
	var direction = Input.get_axis("w_up", "s_down")
	# Set the speed and the direction in the Y axis
	linear_velocity.y = direction * speed
	# Lock the X axis velocity
	linear_velocity.x = 0
