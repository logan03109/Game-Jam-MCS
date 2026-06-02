extends CharacterBody2D

@export var left_action := "p2_left"
@export var right_action := "p2_right"
@export var jump_action := "p2_jump"

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

var jump_count:int = 2

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(jump_action) and jump_count != 1:
		velocity.y = JUMP_VELOCITY
		jump_count -= 1 
	if is_on_floor():
		jump_count = 2

	var direction := Input.get_axis(left_action, right_action)

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
