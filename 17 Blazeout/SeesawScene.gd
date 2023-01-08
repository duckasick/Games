extends Node2D

var StrafP = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D2_area_entered(area):
	$SeesawPlayer.position = $Position2D.position
	StrafP += 1
	if StrafP == 3:
		AAA.StrafGlobal += 1
		StrafP = 0

func _on_Area2D_area_entered(area):
	_on_Area2D2_area_entered(area)
