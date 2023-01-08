extends Area2D

signal hit   # Signaal stuurt bericht als conditie ergens aan voldoet, zie hieronder

func _on_Node2D_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)  # Zorgt ervoor dat hit niet elke frame triggerd als enemy in je zit

export var speed = 400 # Met export kan je m in inspector veranderen
var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size  # checkt screen size

func _process(delta):		#Process checkt elke frame, voor movement animation gannoes
	
	# Movement meuk
	var velocity = Vector2.ZERO # The player's movement vector, ook wel (0,0)
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
  # Zodat diagonaal niet harder gaat
		$AnimatedSprite.play()		# $ = get.node()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)    # Zorgt ervoor dat je niet buiten de window gaat
	position.y = clamp(position.y, 0, screen_size.y)	# Clamp restrict
	
	#Animation meuk, flip H voor horizon, V voor verticaal DRAAIT COLLISION NIET OM
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
func start(pos):  #reset player als dood
	position = pos
	show()
	$CollisionShape2D.disabled = false


