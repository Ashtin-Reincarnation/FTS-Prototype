extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func spawnProj(pI):
	var projectileInstance = pI.instantiate()
	add_child(projectileInstance)

func _on_player_projectile(instance):
	spawnProj(instance)
	
func _on_player_hold():
	var child = get_child(get_child_count()-1)
	child.position.x=$Player.position.x
	child.position.y=$Player.position.y
