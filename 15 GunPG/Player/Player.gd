extends KinematicBody2D

const bulletPath = preload("res://Gannoe/kogel.tscn")
const knockback = preload("res://Gannoe/kogel.tscn")

onready var animationP = $AnimationPlayer
onready var animationT = $AnimationTree
onready var animationS = animationT.get("parameters/playback")

var startspeed = 280
export var speed = 280			#Geen const, want evt ingame aanpassen vvvvv
var accel = speed*10
var velocity = Vector2.ZERO
var multp = 2
var roll_vector = Vector2.DOWN
var STATE = 0
var dashspeed = 400
var dashaccel = dashspeed * 10
var canfire = true
var magazijnsize = 7
var magazijn = magazijnsize
var attackspeed = 0.2
var canroll = true


enum {
	MOVE, 
	ROLL,
	RELOADING,
	}

func _ready():
	animationT.active = true
	$"Player/Dash-Sheet".visible = false
	$"Player/Reload".visible = false

func _process(delta):   # geen physics, want gebruiken we niet
	match STATE:    #beetje zoals switch 
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
			
	$Label.text = str("ammo: ", magazijn)

func move_state(delta): 
#	Input ---
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		#Animatiemeuk ---
	if input_vector != Vector2.ZERO:
		velocity += input_vector * accel * delta
		velocity = velocity.clamped(speed)
		roll_vector = input_vector
		animationT.set("parameters/Idle/blend_position", input_vector)		#Vector bepaald welke animatie aan gaat
		animationT.set("parameters/Run/blend_position", input_vector)
		animationT.set("parameters/Roll/blend_position", input_vector)
		animationS.travel("Run")
	else:
		animationS.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, accel*delta)
	velocity = move_and_slide(velocity)
#	Dash ---
	if Input.is_action_just_pressed("roll") and canroll:
		canfire=false
		STATE = ROLL
		
#	Attack, geen manual reload ---
	if Input.is_action_pressed("attack") and canfire: 
		attack()
		
	$Richting.look_at(get_global_mouse_position())
	
#	Overige inputs
	if Input.is_action_just_pressed("ui_cancel"):		#esc to menu
		get_tree().change_scene("res://Menu.tscn")
	if Input.is_action_just_pressed("R"):
		get_tree().reload_current_scene()

# Attack functie
func attack():
	# Geluid afspelen????
	canfire= false
	magazijn -= 1
	shoot()
	yield(get_tree().create_timer(attackspeed), "timeout")
	if magazijn == 0:
		speed = speed / 2
		print("MagazijnTest")
		$"Player/Reload".frame = 0   #Voorkomt dat animatie soms op andere frame start
		$"Player/Reload".visible = true
		#ook hier geluid afspelen?????
		animationP.play("Reloading")
	else: canfire = true


#	RELOAD MEUK Kan ook voor andere dingen gebruik worden, is nu in reload anim getriggerd
func gun_enable(): 
	canfire= true
	print("MagazijnTest2")
	$"Player/Reload".visible = false
	speed = startspeed
	magazijn = magazijnsize

#	ROL MEUK
func roll_state(delta):
	velocity += roll_vector * dashaccel * multp * delta # Heeft misschien deaccel nodig, misschien in animatie met functie regelen?
	velocity = velocity.clamped(dashspeed)
	animationS.travel("Roll")
	velocity = move_and_slide(velocity)
func roll_anim_finished():
	STATE = MOVE
	if magazijn != 0: 
		canfire=true
func dash_anim_finished():
	$"Player/Dash-Sheet".visible = false

func shoot():	#Kogel kan verkeerde kant op gaan als je te dicht op de player richt
	var bullet = bulletPath.instance()
	
	get_parent().add_child(bullet)
	bullet.position = $Richting/Sprite/Barrel.global_position
	
	bullet.vel = get_global_mouse_position() - bullet.position
	




# Oude meuk, niet teveel kijken


# Avert your eyes, children 

#var velocity = Vector2()
#var speed = 200
#var status
#onready var animation = $AnimationPlayer # IPv in _ready
#onready var animationT = $AnimationTree
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
#
#func get_input():
#	velocity = Vector2()
#	if Input.is_action_pressed("ui_left"):
#		velocity.x -= speed
#	if Input.is_action_pressed("ui_right"):
#		velocity.x += speed
#	if Input.is_action_pressed("ui_down"):
#		velocity.y += speed
#	if Input.is_action_pressed("ui_up"):
#		velocity.y -= speed
#	if velocity.length() > 0:
#		COCK = velocity.normalized()
#		velocity = velocity.normalized() * speed
#	velocity = move_and_slide(velocity)
#	print(velocity)
#
#
#	#Animatiemeuk, snap er weinig van
#func _physics_process(delta):
#	get_input()
#	if velocity != Vector2(0,0)*200:
#		animationT.set("parameters/idle/blend_position", velocity)
#		animationT.set("parameters/Run/blend_position", velocity)
#
#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
