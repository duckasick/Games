extends Node2D

onready var Spawn = $Position2D.position
var StrafP = 0

var can_drag = false
var array = [1, 2, 3]
var KleurHok = 1
var doel1 = false
var doel2 = false
var doel3 = false
var check = false

func _ready():
	KleurHok = array[randi() % array.size()]
	get_node("Tijd").set("custom_colors/default_color", Color(1,0,0,1))
	
func _process(delta):
	$Tijd.text = str($Timer.time_left)
	if KleurHok == 1:
		doel1 = true
		$TehuisDragNDropV2/ColorRect.color = Color(1, 0, 0, 1)
	if KleurHok == 2:
		doel2 = true
		$TehuisDragNDropV2/ColorRect.color = Color(0, 1, 0, 1)
	if KleurHok == 3:
		doel3 = true
		$TehuisDragNDropV2/ColorRect.color = Color(0, 0, 1, 1)
	$Strafpunten.text = str(StrafP)
	if StrafP == 3:
		AAA.StrafGlobal += 1
		StrafP = 0
	if check == true: 
		get_node("Tijd").set("custom_colors/default_color", Color(0,1,0,1))
	if check == false: 
		get_node("Tijd").set("custom_colors/default_color", Color(1,0,0,1))
	
	
#doel 1
func _on_Doel1_area_entered(area):
	if doel1: 
		check = true
		doel1 = false
		print("goed")
	else: 
		StrafP += 1
		print("fout")
	$TehuisDragNDropV2.position = Spawn
	KleurHok = array[randi() % array.size()]

	
#doel 2
func _on_Doel2_area_entered(area):
	if doel2: 
		check = true
		doel2 = false
		print("goed")
	else: 
		StrafP += 1
		print("fout")
	$TehuisDragNDropV2.position = Spawn
	KleurHok = array[randi() % array.size()]


func _on_Doel3_area_entered(area):
	if doel3: 
		check = true
		doel3 = false
		print("goed")
	else: 
		StrafP += 1
		print("fout")
	$TehuisDragNDropV2.position = Spawn
	KleurHok = array[randi() % array.size()]



func _on_Timer2_timeout():
	$Timer.start()


func _on_Timer_timeout():
	if check == false:
		StrafP+=1
	check = false
