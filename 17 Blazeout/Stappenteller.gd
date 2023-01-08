extends Node2D

var stapAnim = 0
var Stappen = 0
var StappenD = 10
var check = false
var StrafP = 0
var tijd = 200
var starttijd = 200
var Start = false

func _ready():
	$Stapdoel.text = str(StappenD)
	$Stappen.text = str(Stappen)
	$Tijd.text = str(tijd)
	$Strafpunten.text = str(StrafP)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		stapAnim += 1
		if stapAnim == 3:
			stapAnim = 0
		$Sprite.set_frame(stapAnim)
		Stappen += 1
		$Stappen.text = str(Stappen)
	if Stappen >= StappenD:
		check = true	
		$Stappen.text = ("Genoeg!")
	elif check == false:
		$Stappen.text = str(Stappen)
	if StrafP == 3:
		StrafP = 0
		$Strafpunten.text = str(StrafP)
		AAA.StrafGlobal += 1
	if $Tijd.text == "50":
		get_node("Tijd").set("custom_colors/default_color", Color(1,0,0,1))		

func _on_Timer_timeout():
	tijd -= 1
	$Tijd.text = str(tijd)
	if tijd == 0:
		$Tijd.text = str(starttijd)
		tijd = starttijd
		Stappen = 0
		$Stappen.text = str(Stappen)
		get_node("Tijd").set("custom_colors/default_color", Color(1,1,1,1))		
		if not check:
			StrafP += 1
			$Strafpunten.text = str(StrafP)


func _on_Starttimer_timeout():
	$Timer.start()
