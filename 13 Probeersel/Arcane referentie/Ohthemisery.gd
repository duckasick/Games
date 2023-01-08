extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()

func _physics_process(delta):
	var Player = get_parent().get_node("res://Player/Player.tscn")
	move_and_collide(motion)
	
	
