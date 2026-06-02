extends CharacterBody2D

@export var left_action := "p1_left"
@export var right_action := "p1_right"
@export var jump_action := "p1_jump"
@export var down_action := "p1_down"

const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const DOWN_VELOCITY = -900.0
const INIT_ACCEL = 4500.0
const FRICTION = 2500.0
const AIR_RESISTANCE = 500.0

var jump_count:int = 2
var time_passed:float = 0.0

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		jump_count = 2
	
	if Input.is_action_just_pressed(jump_action) and jump_count > 0:
		jump_count -= 1 
		velocity.y = JUMP_VELOCITY	
	
	if Input.is_action_just_pressed(down_action) and not is_on_floor():
		velocity.y = velocity.y - DOWN_VELOCITY

	var direction := Input.get_axis(left_action, right_action)
	
	if direction and not is_on_floor():
		velocity.x = move_toward(velocity.x, direction * SPEED, INIT_ACCEL * delta)
	elif direction:
		velocity.x += 50
		velocity.x = move_toward(velocity.x, direction * SPEED, INIT_ACCEL * delta)
		#velocity.x = direction * SPEED
	elif not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, AIR_RESISTANCE * delta)
		pass
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
