extends Line2D

const path = preload("res://Kogel.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	look_at(get_global_mouse_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
