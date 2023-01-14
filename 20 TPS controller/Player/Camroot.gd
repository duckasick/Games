extends Spatial

var camh = 0
var camv = 0
var camv_min = -55
var camv_max = 75
export var Sens = 0.05
var mouse = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$h/v/ClippedCamera.add_exception(get_parent())

func _input(event):
	if event is InputEventMouseMotion:
		camh += -event.relative.x * Sens
		camv += -event.relative.y * Sens
	if Input.is_action_just_pressed("l"):
		mouse = not mouse
#Regel input
func _physics_process(delta):
	camv = clamp(camv, camv_min, camv_max) #Zodat camera niet te ver gaat
	$h.rotation_degrees.y = camh
	$h/v.rotation_degrees.x = camv
	if mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if not mouse:	
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
