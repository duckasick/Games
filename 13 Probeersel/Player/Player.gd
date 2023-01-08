extends KinematicBody2D  # Doet player bewegen

const bulletPath = preload("res://gUN/kogel.tscn")

var velocity = Vector2() # houdt bij waar player beweegt

export var speed = 200  # export zodat deze overal gebruikt kan worden 	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	if Input.is_action_just_pressed("boom"):
		shoot()
		print("wolah")
		
	$Node2D.look_at(get_global_mouse_position())
func shoot():
	var bullet = bulletPath.instance()
	
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Position2D.global_position
	
	bullet.vel = get_global_mouse_position() - bullet.position

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func kill():
	get_tree().change_scene("res://Menu.tscn")
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_Area2D_body_entered(body):
	if "res://Arcane referentie/Ohthemisery.tscn" in body.name:
		kill()
