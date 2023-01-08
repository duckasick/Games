extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var game = 0
var TotPauze = 0
var StartSpeed = 0.6

func _ready():
	$RichTextLabel3.text = "Timescale = " + str(AAA.scale) + "x"
	$Mindfullness2.hide()
	AAA.scale = StartSpeed
	
func _process(delta):
	$RichTextLabel.text = str($VolgendeGame.time_left)
	$RichTextLabel2.text = "Strafpunten:" + str(AAA.StrafGlobal)
	print($Mindfullness.time_left)
	
func _on_Pauze_pressed():
	get_tree().paused = not get_tree().paused

func _on_Button2_pressed():
	get_tree().change_scene("res://AAAAMENU.tscn")
	get_tree().paused = false

func _on_VolgendeGame_timeout():
	game += 1
	if game >= 7:
		$VolgendeGame.stop()
		$RichTextLabel.hide()
		
#Mindfullness timer
func _on_Mindfullness_timeout():
	randomize()
	TotPauze = rand_range(20, 40)
	$Mindfullness.wait_time = TotPauze
	$Mindfullness2.show()
	get_tree().paused = not get_tree().paused
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().paused = not get_tree().paused
	$Mindfullness2.hide()
	




func _on_Button_pressed():
	AAA.scale += 0.05
	$RichTextLabel3.text = "Timescale = " + str(AAA.scale) + "x"
