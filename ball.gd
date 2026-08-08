extends RigidBody2D

# Ball Velocity
@export var initVelocity: Vector2 = Vector2(400, 0)
@export var maxAngle: float = 0.0

func _physics_process(delta: float) -> void:
	# Event collide
	var collide = move_and_collide(initVelocity * delta)
	# CollisionShape2D Object
	var collisionObject: Node2D = Node2D.new()
	# Stores the point of impact along the paddle Y axis
	var pointOfImpact: float = 0.0
	# Calculates the speed and adds the bounce
	var speed: Vector2 = Vector2.ZERO
	# Inverts the pointOfImpact X values to mirror right and left X force
	var angle: float = 0.0
	# Sets the max angle in which the ball bounces by
	if collide:
		# Gets the CollisionShape2D from the event collide
		collisionObject = collide.get_collider_shape()
		# Checks if the collided object is from Paddle Group
		if collisionObject.is_in_group("Paddle"):
			# Gets the point of impact along the Paddle Y axis lenght
			pointOfImpact = (collide.get_position().y - collisionObject.global_position.y) / (collisionObject.shape.size.y / 2.0)
			# Gets the initial speed of the ball, the logic of move_and_collide and the bounce logic to integrate all three
			speed = initVelocity.bounce(collide.get_normal())
			# Applying the logic to the velocity
			initVelocity = speed
			# Sets the pointOfImpact to the angle
			angle = pointOfImpact
			# Checks whether the ball is moving to the right or left
			if initVelocity.x > 0:
				# Rotating the ball from the point of impact along the paddle Y axis
				initVelocity = initVelocity.rotated(pointOfImpact * 0.1)
				print(pointOfImpact)
			else:
				# Normalizing the X axis
				angle = -angle
				# Rotating with the fixed X axis
				initVelocity = initVelocity.rotated(angle)
				print(pointOfImpact)
			# Applying the velocity boost upon hitting a paddle
			initVelocity.x *= 1.05
			initVelocity.y *= 1.05
		else:
			# It just bounce without the angle and speed boots it it didn't hit a paddle
			initVelocity = initVelocity.bounce(collide.get_normal())
			initVelocity = initVelocity.rotated(pointOfImpact * 0.1)
