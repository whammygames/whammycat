extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var maxHorizontalSpeed = 500
var isDead = false


func _physics_process(delta):
	if isDead:
		return
	if shouldDie():
		die()
		print("Player should die")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func shouldDie() -> bool:
	return position.y > 500


func die():
	print("The player is dead")
	isDead = true
	restartLevel()

func restartLevel():
	print("The level should reload now")
	get_tree().change_scene_to_file("res://Scenes/DeathScreen.tscn")
	
func _process(delta):
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left")
	
	velocity.x = moveVector.x * maxHorizontalSpeed



func _on_death_tree_entered():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
