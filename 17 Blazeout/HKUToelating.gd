extends Node2D

var check = false
var StrafP = 0
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Hey = $LineEdit.text
	var length = Hey.length()
	if length == 20:
		check = true
	if StrafP == 3:
		AAA.StrafGlobal += 1
		StrafP = 0
	if check:
		$RichTextLabel.text = "Klaar!"
		get_node("RichTextLabel").set("custom_colors/default_color", Color(0,1,0,1))	
		get_node("RichTextLabel2").set("custom_colors/default_color", Color(0,1,0,1))	
	else:
		$RichTextLabel.text = "Typen!"
		get_node("RichTextLabel").set("custom_colors/default_color", Color(1,0,0,1))
		get_node("RichTextLabel2").set("custom_colors/default_color", Color(1,0,0,1))				
	$RichTextLabel2.text = str($Timer.time_left)
	
	



func _on_Timer_timeout():
	if check == false:
		StrafP += 1
	$LineEdit.text = ""
	check = false
	
	

func _on_Timer2_timeout():
	$Timer.start()

func _on_LineEdit_mouse_exited():
	$LineEdit.release_focus()
