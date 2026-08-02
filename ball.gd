extends RigidBody2D

@export var initVelocity: Vector2 = Vector2(400, 20)

func _physics_process(delta: float) -> void:
	var collide = move_and_collide(initVelocity * delta)
	if collide && body_entered("Paddle"):
		initVelocity = initVelocity.bounce(collide.get_normal())
		initVelocity.x *= 1.05
		initVelocity.y *= 1.05
