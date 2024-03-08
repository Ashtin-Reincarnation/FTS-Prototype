extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("obstacles")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("stop"):
		body.stop(1)
		body.has_stopped=true
		body.linear_velocity=Vector2.ZERO
