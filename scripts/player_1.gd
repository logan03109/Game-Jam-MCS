extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -800.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

<<<<<<< Updated upstream:scripts/cube.gd
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
=======
	if is_on_floor():
		jump_count = 2
	
	if Input.is_action_just_pressed(jump_action) and jump_count > 0:
		jump_count -= 1 
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis(left_action, right_action)
>>>>>>> Stashed changes:scripts/player_1.gd

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
