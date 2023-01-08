extends Node2D

var InBed = false
var SlaapTijd = 0
var SlaapDag = 200
var StrafP = 0
var StrafG = true  #Voorkomt teveel strafpunten

func _ready():
	$Status.text = "Wakker"
	$Tijd.text = str(SlaapTijd)
	$InBed.text = ("InBed = " + str(InBed))
	$Strafpunten.text = ("Strafpunten = " + str(StrafP))
	get_node("Status").set("custom_colors/default_color", Color(0,1,0,1))
	

func _on_Timer_timeout():
	$Slaaptimer.start

func _on_SlaapKnop_pressed():
	InBed = not InBed
	$InBed.text = ("InBed = " + str(InBed))

func _on_Slaaptimer_timeout():
	SlaapTijd += 10
	if SlaapTijd == SlaapDag:
		SlaapTijd = 0
	$Tijd.text = str(SlaapTijd)
	
	#In bed optijd
	if SlaapTijd >= 70 and SlaapTijd < 130:
		$Status.text = "Bedtijd"
		get_node("Status").set("custom_colors/default_color", Color(0,1,0,1))
		if not InBed:
			$Status.text = "Te laat"
			get_node("Status").set("custom_colors/default_color", Color(1,0,0,1))
			if not StrafG:
				Straf()
	
	#Waarschuwing en reset StrafG
	elif SlaapTijd >= 50 and SlaapTijd < 150:
		$Status.text = "Tijd voor bed / Opstaan"
		get_node("Status").set("custom_colors/default_color", Color(1,1,0,1))
		StrafG = false
		
	#Check voor overdag slapen
	elif InBed:
		$Status.text = "Opstaan"
		get_node("Status").set("custom_colors/default_color", Color(1,0,0,1))
		if not StrafG:
			Straf()
	else: 
		$Status.text = "Wakker"
		
func Straf():
	StrafP += 1
	StrafG = true
	if StrafP == 3:
		AAA.StrafGlobal += 1
		StrafP = 0
		$Strafpunten.text = ("Strafpunten = " + str(StrafP))
