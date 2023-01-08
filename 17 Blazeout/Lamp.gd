extends Node2D

#Lamp
var LampOpaci = 0
var r = 0
var LampSwitch = true
var MaxMoney = 2000
var Money = MaxMoney
var StrafP = 0
var Start = false

func _ready():
	$RichTextLabel2.text = ("Max geld = ") + str(MaxMoney)
	$RichTextLabel3.text = str(StrafP)

func _on_Timer_timeout():
	Start = true

func _process(delta):
		if Start:
			match LampSwitch:    #beetje zoals switch 
				true:
					LampAan()
				false:
					LampUit()
			$RichTextLabel.text = str(Money)
			if Money < 500:
				get_node("RichTextLabel").set("custom_colors/default_color", Color(1,0,0,1))
			else:
				get_node("RichTextLabel").set("custom_colors/default_color", Color(1,1,1,1))
			if Money == 0 and StrafP == 3:
				AAA.StrafGlobal += 1
				print("HE")
				Money = MaxMoney
				StrafP = 0
			elif Money == 0:
				StrafP += 1
				Money = MaxMoney
				print("YE")
			if Money >= MaxMoney:
				Money = MaxMoney -2 # -2, want anders 2002
			$RichTextLabel3.text = str(StrafP)
func LampAan():
	Money -= 1
	$ColorRect.color = Color(0, 0, 0, 0)
	LampOpaci = 0

func LampUit():
	LampOpaci += 0.001
	$ColorRect.color = Color(0, 0, 0, LampOpaci)
	Money += 2
func _on_LichtSwitch_pressed():
	LampSwitch = not LampSwitch


# 	Poging om lamp gelijdelijk aan steeds sneller te dimmen
#	Kan wel, maar moet wel goed gefinetuned worden. 

#	var t = 1
#	var n = 6
##	LampOpaci = LampOpaci + 0.001
#	LampOpaci += pow((r/n), 49/t) * 0.000000000001
#	r += 0.01
