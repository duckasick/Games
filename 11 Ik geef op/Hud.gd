extends CanvasLayer

signal startgame

func show_message(text):
	$Label2.text = text
	$Label2.show()
	$Timer.start()
	

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($Timer, "timeout")
	$Label2.text = "Dodge the\nCreeps"
	$Label2.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$Button.show()

func update_score(score):
	$Score.text = str(score)

func _on_Button_pressed():
	$Button.hide()
	emit_signal("startgame")

func _on_Timer_timeout():
	$Label2.hide()


