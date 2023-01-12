extends KinematicBody

#Te doen: Accel ipv gelijkt topV, snelheid uncappen als je in de lucht bent

var Velocity = Vector3.FORWARD
var VeloV = 0

var V = 5
var sprint = 10
var normaal = 5
var impulse = 10
var weight = 4 #Bepaald hoe makkelijk je van schuin slide.

var gravity = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rot = $Camroot/h.global_transform.basis.get_euler().y
#	Roteert roteert input gebasseerd op camera_h
	Velocity = Vector3(Input.get_action_strength("d") - Input.get_action_strength("a"),0,Input.get_action_strength("s") - Input.get_action_strength("w")).rotated(Vector3.UP, rot).normalized() #	Roteert roteert input gebasseerd op camera_h
#
#	Zwaartekracht
	if !is_on_floor():
		VeloV -= gravity * delta	
	else:
		VeloV = 0
	
#	Sprinten
	if Input.is_action_pressed("sprint"):
		V = sprint
	else: 
		V = normaal
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			VeloV = impulse
	
	move_and_slide(Velocity * V + Vector3.UP * VeloV - get_floor_normal() * weight, Vector3.UP)
