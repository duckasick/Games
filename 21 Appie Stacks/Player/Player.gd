extends KinematicBody

#Te doen: snelheid uncappen als je in de lucht bent, CSGO strafe < misschien niet?

var Direction = Vector3.FORWARD
var Velocity = Vector3.ZERO
var VeloV = 0

var V = 20
var LV = 40
export var accel = 10
export var Gaccel = 10
export var Laccel = 2
export var sprint = 35
export var normaal = 20
export var impulse = 30	#jump
export var boostPlus = 30

export var weight = 4 #Bepaald hoe makkelijk je van schuin slide.

export var gravity = 80
export var GravityN = 80
export var GravityJ = 35
export var GravityD = 110
var GravityTrigger = false

var drifting = false
var Tstart = false		#Fixt probleem met _pressed en timer starten
var boostready = false
var sprinting = false


func _ready():
	pass # Replace with function body.


#OPTIES VOOR ACCEL TOEVOEGEN
func _physics_process(delta):
	var rot = $Camroot/h.global_transform.basis.get_euler().y
#	Roteert roteert input gebasseerd op camera_h
	$CSGCylinder.rotation.y = rot
	$CollisionShape.rotation.y = rot
#	Roteert hitbox en cylinder naar camera

	if not drifting:
		Direction = Vector3(Input.get_action_strength("d") - Input.get_action_strength("a"),
		0,
		Input.get_action_strength("s") - Input.get_action_strength("w")).rotated(Vector3.UP, rot).normalized()
#	if GlobalAccel:
#		Accel optie hier

#	Minder controle in lucht
	if !is_on_floor():
		accel = Laccel
		Velocity = lerp(Velocity, Direction * LV, delta * Laccel) # DIT MOET FF ANDERS
	if is_on_floor(): 
		accel = Gaccel
		Velocity = lerp(Velocity, Direction * V, delta * Gaccel)


#	Zwaartekracht 
	if !is_on_floor():
		VeloV -= gravity * delta

#	Jump	#GT = zie timer
	if is_on_floor():
		VeloV = 0
		if Input.is_action_just_pressed("ui_select"):
			VeloV += impulse
#			$timers/jump.start()
#			if GJump:
			gravity = GravityJ

	if Input.is_action_just_released("ui_select") or GravityTrigger:
		gravity = GravityN
		
#	Sprinten
	if Input.is_action_just_pressed("sprint"):
		V = sprint
		sprinting = true
	if Input.is_action_just_released("sprint"):
		V = normaal
		sprinting = false
		
#	Dropdown
	if !is_on_floor():
		if Input.is_action_pressed("dive"):
			gravity = GravityD
		elif Input.is_action_just_released("dive"):
			gravity = GravityN
		
#	Drift
	if is_on_floor():
		var LaatsteV = Velocity
		if Input.is_action_pressed("dive"):  #Niet just, want dan kan niet vanuit jump
			drifting = true
			Velocity = LaatsteV	
			if Tstart==false:
				$timers/drift.start()
				Tstart = true
		if Input.is_action_just_released("dive"):
			drifting = false
			Tstart = false
			$timers/drift.stop()
			if boostready:
				V += boostPlus
				boostready = false
				$timers/driftboost.start()
				$HUD/ColorRect.color = Color(0,1,0,1)
			$HUD/ColorRect2.color = Color(1,0,0,1)
		
	move_and_slide(Velocity + Vector3.UP * VeloV - get_floor_normal() * weight, Vector3.UP)
	print (V)

#	Ready boost
func _on_drift_timeout():
	boostready = true
	$HUD/ColorRect2.color = Color(0,1,0,1 )
func _on_driftboost_timeout():
	if sprinting:
		V = sprint
	else: V = normaal
	$HUD/ColorRect.color = Color(1,0,0,1 )



func _on_Boostpad_boost(value):
	V += 20
	print(V)
	get_tree().quit()
