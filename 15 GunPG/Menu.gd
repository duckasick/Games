extends Node2D

var omega = 2

enum {
	START
	LINKS, 
	RECHTS,
	}
var state = START

func _process(delta):   # geen physics, want gebruiken we niet
	match state:    #beetje zoals switch 
		LINKS:
			LINKS(delta)
		RECHTS:
			RECHTS(delta)
		START:
			start(delta)		
 # Screenshot rotation. Is dit handig?
func start(delta):
	$"2019-07-09182728-Window".rotate(0.2 * delta)
	yield(get_tree().create_timer(omega/2), "timeout")
	state = LINKS	
func LINKS(delta):
	$"2019-07-09182728-Window".rotate(-0.2 * delta)
	yield(get_tree().create_timer(omega), "timeout")
	state = RECHTS
func RECHTS(delta):
	$"2019-07-09182728-Window".rotate(0.2 * delta)
	yield(get_tree().create_timer(omega), "timeout")
	state = LINKS
	
func _ready():
	$BB.visible = false
	$Music.play()

#Quit
func _on_Button2_pressed():
#	$BB.visible = true			#Get stickbugged
#	$BB.play()
#	$Music.stop()
	get_tree().quit()
func _on_BB_finished():
	get_tree().quit()

#Start
func _on_Button_pressed():
	get_tree().change_scene("res://Overworld.tscn")
	
