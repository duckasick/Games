extends Node2D

#Dubbel RTF label, want duidelijker. 

func _on_Button_pressed():
	get_tree().change_scene("res://AAAAMENU.tscn")

var state = 0
	
func _on_Animatie_timeout():
	if state == 0:
		$Button.text = ">  >   TERUG NAAR MENU   <  <"
	elif state == 1:
		$Button.text = "   >  >TERUG NAAR MENU<  <   "
	elif state == 2: 
		$Button.text = ">     >TERUG NAAR MENU<     <"
	state +=1
	if state >2:
		state =0
