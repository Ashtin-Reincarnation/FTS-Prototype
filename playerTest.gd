extends CharacterBody2D
var arrowScene = preload("res://arrowTest.tscn")

const SPEED = 20.0
signal projectile
signal hold
var angle
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	if Input.is_action_just_pressed("leftClick"):
		emit_signal("projectile",arrowScene)
		
	if Input.is_action_pressed("leftClick"):
		emit_signal("hold")
		
	var mouse_position = get_global_mouse_position()
	
	
	# Get the direction from the object to the mouse position
	var direction = (mouse_position - global_position).normalized()
	
	
	# Calculate the angle between the object and the mouse position
	angle = atan2(direction.y, direction.x)
	if angle>deg_to_rad(90) or angle<deg_to_rad(-90):
		if $AnimatedSprite2D.flip_h == true:
			$AnimatedSprite2D.flip_h = false
	else:
		if $AnimatedSprite2D.flip_h == false:
			$AnimatedSprite2D.flip_h = true
	
	if velocity.x!=0 or velocity.y!=0:
		$AnimatedSprite2D.animation="sprint left"
	else:
		$AnimatedSprite2D.animation="idle left"
	var directionx = Input.get_axis("ui_left", "ui_right")
	var directiony = Input.get_axis("ui_up", "ui_down")

	
	if directionx or directiony:
		velocity.x = directionx * SPEED
		velocity.y = directiony * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = 0
	move_and_slide()
	
	
