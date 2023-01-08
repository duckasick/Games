extends KinematicBody2D

export var speed = 250  # How fast the player will move (pixels/sec).
var screen_size 
var grab = false
var start = false

func _ready():
	screen_size = get_viewport_rect().size

var velocity = Vector2.ZERO



func _move_to_mouse(delta):
	if grab:
		var direction = get_global_mouse_position() - position
		position.x += 0 - 45
		position.y += 0 - 270
		move_and_collide(direction)
		
func _process(delta):
	if grab:
		position += velocity * delta
		_move_to_mouse(delta)


func _on_Button_pressed():
	if start:
		grab = true

func _on_Collisioncheck_area_entered(area):
	grab = false
	
	


func _on_Timer_timeout():
	start = true
