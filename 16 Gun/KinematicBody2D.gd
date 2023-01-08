extends KinematicBody2D

const bulletPath = preload("res://kogel.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		
	$Node2D.look_at(get_global_mouse_position())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func shoot():
	var bullet = bulletPath.instance()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Position2D.global_position
	
	bullet.vel = get_global_mouse_position() - bullet.position
	
