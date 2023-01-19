extends Node2D


func _on_Button_pressed():
	GV.Accel = true
	get_tree().change_scene("res://Level.tscn")
	print (GV.Accel)

func _on_Button2_pressed():
	GV.GJump = true
	get_tree().change_scene("res://Level.tscn")
	print (GV.GJump)

func _on_Button3_pressed():
	GV.GJump = true
	GV.Accel = true
	get_tree().change_scene("res://Level.tscn")
	print (GV.GJump)
	print (GV.Accel)
