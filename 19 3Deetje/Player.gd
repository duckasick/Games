extends KinematicBody

var velocity = Vector3.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 100
var v = 10
var impulse = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y -= v * delta
	var direction = Vector3.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
#	XZ-plane is grond
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	velocity.x = direction.x * v
	velocity.z = direction.z * v

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y += impulse

	velocity.y -= speed * delta
	velocity = move_and_slide(velocity, Vector3.UP)
