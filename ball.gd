extends RigidBody2D

# Ball Velocity
@export var initVelocity: Vector2 = Vector2(400, 0)
# Controls the intensity of angle bounce
@export var maxAngle: float = 0.0
# Ball initial position
var ballInitPosition: Vector2 = self.global_position
# Ball initial velocity
var ballInitVelocity: Vector2 = Vector2(400,0)
var ballResetMove: Variant

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
				initVelocity = initVelocity.rotated(pointOfImpact * maxAngle)
				print(ScoringSystem.pOneScore)
				print(ScoringSystem.pTwoScore)
			else:
				# Normalizing the X axis
				angle = -angle
				# Rotating with the fixed X axis
				initVelocity = initVelocity.rotated(angle * maxAngle)
				print(ScoringSystem.pOneScore)
				print(ScoringSystem.pTwoScore)
			# Applying the velocity boost upon hitting a paddle
			initVelocity.x *= 1.07
			initVelocity.y *= 1.07
		else:
			# It just bounce without the angle and speed boots it it didn't hit a paddle
			initVelocity = initVelocity.bounce(collide.get_normal())
			initVelocity = initVelocity.rotated(pointOfImpact * maxAngle)
			print(ScoringSystem.pOneScore)
			print(ScoringSystem.pTwoScore)
		# Checks if ball collides with the map left and right map borders
		if collisionObject.is_in_group("OutOfMapLeft"):
			ScoringSystem.pTwoScore += 1
			endGame()
		if collisionObject.is_in_group("OutOfMapRight"):
			ScoringSystem.pOneScore += 1
			endGame()

func endGame():
	self.position = ballInitPosition
	self.initVelocity = ballInitVelocity
	self.linear_velocity = Vector2(0.0, 0.0)
