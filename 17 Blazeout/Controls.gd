extends Node2D

#Dubbel RTF label, want duidelijker. 
var state = 0
	
func _on_Button_pressed():
	get_tree().change_scene("res://Controls2.tscn")


func _on_Animatie_timeout():
	if state == 0:
		$Button.text = ">  >   VOLGENDE   <  <"
	elif state == 1:
		$Button.text = "   >  >VOLGENDE<  <   "
	elif state == 2: 
		$Button.text = ">     >VOLGENDE<     <"
	state +=1
	if state >2:
		state =0

