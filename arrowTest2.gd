extends RigidBody2D

var arrow_speed=10
var max_arrow_speed = 400
var distance_to_travel = 0
var max_distance = 100
var charge_speed_modifier = 0.5
var has_traveled = false
var ini_pos=global_position
var dist_traveled=0
var has_stopped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_deferred("disabled",true)
	$Sprite2D.visible=true
	add_to_group("projectiles")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Left Click
	if Input.is_action_pressed("leftClick"):
		if has_traveled==false:
			#Charges up the max distance
			distance_to_travel +=max_distance*delta*charge_speed_modifier
			distance_to_travel = min(distance_to_travel, max_distance)
		#Charges up the max arrow speed
		arrow_speed +=max_arrow_speed*delta*charge_speed_modifier
		arrow_speed = min(arrow_speed, max_arrow_speed)
		#print("arrowspeed: ", arrow_speed)
		#print("disttravel: ", distance_to_travel)
	
	#Rotate arrow to mouse
	if has_traveled==false:
		rotation= Vector2(get_global_mouse_position() - global_position).normalized().angle() + deg_to_rad(90)
	
	#Release left click
	if Input.is_action_just_released("leftClick"):
		#Enable collider
		if has_traveled==false:
			$CollisionShape2D.set_deferred("disabled",false)
		#Make sprite visible
		$Sprite2D.visible=true
		launchArrow()
		

#Sets initial positions and distances while also assigning the linear velocity once
func launchArrow():
	var mouse_position = get_global_mouse_position()
	var direction = Vector2(mouse_position - global_position).normalized()
	
	if has_traveled==false:
	# Store the initial position of the projectile
		has_traveled=true
		dist_traveled=0
		ini_pos = global_position
		linear_velocity = direction * arrow_speed
	
	
	
func _integrate_forces(_state):
	dist_traveled=global_position.distance_to(ini_pos)
	print("linear velo: ", linear_velocity)
	
	if dist_traveled>distance_to_travel and has_traveled==true and has_stopped==false:
		stop(1)
		#print("max reached")
		has_stopped=true
		
		
func stop(time):
	linear_velocity=Vector2.ZERO
	$Timer.wait_time=time
	$Timer.start()
	#print("projectile stopped")
	$CollisionShape2D.set_deferred("disabled",true)
	
	
func _on_timer_timeout():
	queue_free()




