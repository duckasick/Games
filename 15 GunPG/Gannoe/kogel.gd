extends KinematicBody2D

var vel = Vector2(0,0)
var speed = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	var collision_info = move_and_collide(vel.normalized()*delta * speed)
	rotate(4 * delta)
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2), "timeout")
	queue_free()


	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hitbox_area_entered(area):
	queue_free()
