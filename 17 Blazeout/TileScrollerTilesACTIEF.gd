extends KinematicBody2D

var vel = Vector2(0,1)
var speed = 15
var Geklikt = false
var StrafP = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	var collision_info = move_and_collide(vel.normalized()*delta * speed)
	if AAA.StrafPTile == 3:
		AAA.StrafGlobal += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(6), "timeout")
	if Geklikt == false:
		AAA.StrafPTile += 1
	Geklikt = false
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	Geklikt = true
	AAA.scoreTile += 1
	$Button.visible = false
