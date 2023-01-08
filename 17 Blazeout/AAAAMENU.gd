extends Node2D

var omega = 2

enum {
	START
	LINKS, 
	RECHTS,
	}
var state = START
	
func _ready():
	$BB.visible = false
	$Music.play()
	AAA.scale = 1

func _on_Button2_pressed():
	get_tree().quit()
	

func _on_Button_pressed():
	get_tree().change_scene("res://GAME.tscn")
	

func _on_Button3_pressed():
	get_tree().change_scene("res://Controls.tscn")
















#func _process(delta):   #
#	match state:    #beetje zoals switch 
#		LINKS:
#			LINKS(delta)
#		RECHTS:
#			RECHTS(delta)
#		START:
#			start(delta)
	
	
			
			
 # Is dit handig?
#func start(delta):
#	$"Screen-Shot-2017-04-18-at-143114".rotate(0.2 * delta)
#	yield(get_tree().create_timer(omega/2), "timeout")
#	state = LINKS
#
#func LINKS(delta):
#	$"Screen-Shot-2017-04-18-at-143114".rotate(-0.2 * delta)
#	yield(get_tree().create_timer(omega), "timeout")
#	state = RECHTS
#
#func RECHTS(delta):
#	$"Screen-Shot-2017-04-18-at-143114".rotate(0.2 * delta)
#	yield(get_tree().create_timer(omega), "timeout")
#	state = LINKS
