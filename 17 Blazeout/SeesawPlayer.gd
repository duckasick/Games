extends KinematicBody2D

const WALK_SPEED = 30
var n = 0
var velocity = Vector2()
var Start = false


func _physics_process(delta):
	if Start:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
	#		randi() % (0 - 5) + 5
		if Input.is_action_pressed("ui_right"):
			velocity.x = WALK_SPEED
	#		randi() % (0 - 10) + 10
	#		velocity.x = -n
		move_and_slide(velocity, Vector2(0, 0))


func _on_Timer_timeout():
	Start = true
	#Kiest willekeurige kant
	randomize()
	var a = randi()%2+1
	if a==1:
		velocity.x = -WALK_SPEED
	if a==2:
		velocity.x = WALK_SPEED
