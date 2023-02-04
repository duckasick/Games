extends KinematicBody

#Te doen: Accel ipv gelijkt topV, snelheid uncappen als je in de lucht bent, drift-modus, CSGO strafe

var Velocity = Vector3.FORWARD
var VeloV = 0

export var V = 20
export var sprint = 35
export var normaal = 20
export var impulse = 30	#jump

export var weight = 4 #Bepaald hoe makkelijk je van schuin slide.

export var gravity = 80
export var GravityN = 80
export var GravityJ = 35
export var GravityD = 110
var GravityTrigger = false


func _ready():
	pass # Replace with function body.


#OPTIES VOOR ACCEL TOEVOEGEN
func _physics_process(delta):
	var rot = $Camroot/h.global_transform.basis.get_euler().y
#	Roteert roteert input gebasseerd op camera_h
	$CSGCylinder.rotation.y = rot
	$CollisionShape.rotation.y = rot
#	Roteert hitbox en cylinder naar camera

#	if not GlobalAccel:
	Velocity = Vector3(Input.get_action_strength("d") - Input.get_action_strength("a"),0,Input.get_action_strength("s") - Input.get_action_strength("w")).rotated(Vector3.UP, rot).normalized()
#	if GlobalAccel:
#		Accel optie hier

#	Zwaartekracht 
	if !is_on_floor():
		VeloV -= gravity * delta

#	Jump	#GT = zie timer
	if is_on_floor():
#		GravityTrigger = false
		VeloV = 0
		if Input.is_action_just_pressed("ui_select"):
			VeloV += impulse
#			$timers/jump.start()
#			if GJump:
			gravity = GravityJ

	if Input.is_action_just_released("ui_select") or GravityTrigger:
#		GravityTrigger = true
		gravity = GravityN
		
#	Sprinten
	if Input.is_action_pressed("sprint"):
		V = sprint
	else: 
		V = normaal
	
#	Dropdown
	if Input.is_action_pressed("dive"):
		gravity = GravityD
	elif Input.is_action_just_released("dive"):
		gravity = GravityN
		
	
	move_and_slide(Velocity * V + Vector3.UP * VeloV - get_floor_normal() * weight, Vector3.UP)
	
#	Optionele timer zodat je niet altijd of voor maar zolang gravityJ hebt. 
#func _on_jump_timeout():
#	GravityTrigger = true
#	print("cringe")
