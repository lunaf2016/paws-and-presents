extends CharacterBody2D


const SPEED = 275
const JUMP_VELOCITY = -450

var start_position = Vector2(370,224)

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_just_pressed("Restart"):
		respawn()
			 
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if abs(velocity.x) > 0:
			anim.play("Idle")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#respawn
	
	if position.y < -1000:
		respawn()
	
func respawn():
	position = start_position
