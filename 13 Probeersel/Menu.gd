extends Node2D

func _ready():
	$BB.visible = false

func _on_Button2_pressed():
	$BB.visible = true
#	$BB.play()
	print("balls")
	
func get_input():
	if Input.is_action_pressed("right"):
		get_tree().quit()

func _on_BB_finished():
	get_tree().quit()
	print("bolls")

func _on_Button_pressed():
	get_tree().change_scene("res://Level 1.tscn")
	
