extends CharacterBody2D

const SPEED = 275
const JUMP_VELOCITY: = -450.0
const MAX_JUMP_HOLD_TIME := 0.3

var start_position = Vector2(370,224)
var jump_time = 0.0
var is_jumping = false
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_just_pressed("Restart"):
		respawn()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle jump logic with variable jump height:
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			var v = velocity
			v.y = JUMP_VELOCITY
			velocity = v
			jump_time = 0.0
			is_jumping = true
	else:
		if Input.is_action_pressed("ui_accept") and is_jumping and jump_time < MAX_JUMP_HOLD_TIME:
			var v = velocity
			v.y = JUMP_VELOCITY
			velocity = v
			jump_time += delta
		else:
			is_jumping = false
			var v = velocity
			v.y += get_gravity().y * delta
			velocity = v

		

	# Add gravity if in air and not holding jump (already handled above)
	if not is_on_floor() and not is_jumping:
		velocity.y += get_gravity().y * delta

	# Animations
	if is_on_floor():
		if abs(velocity.x) > 10:
			anim.play("Run")
		else:
			anim.play("Idle")
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false

	move_and_slide()

	# Respawn if fall too far
	if position.y < -1000:
		respawn()

func respawn():
	position = start_position
