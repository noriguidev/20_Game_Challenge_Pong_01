extends RigidBody2D

@export var speed = 600;

func _integrate_forces(state):
	# Get a negative(up) and a positive(down) axis from a keybind to determine the direction
	var direction = Input.get_axis("move_up", "move_down")
	# Set the speed and the direction in the Y axis
	linear_velocity.y = direction * speed
	# Lock the X axis
	linear_velocity.x = 0
