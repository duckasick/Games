extends KinematicBody2D  # Doet player bewegen

const bulletPath = preload("res://kogel.tscn")

var velocity = Vector2() # houdt bij waar player beweegt

export var speed = 200  # export zodat deze overal gebruikt kan worden 	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("down"):
		velocity.y += speed
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func shoot():
	var bullet = bulletPath.instance()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Position2D.global_position
	
	bullet.vel = get_global_mouse_position() - bullet.position
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _on_Knobba_pressed():
	get_tree().change_scene("res://Menu.tscn")
	
