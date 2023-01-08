extends Node2D

onready var Spawn = $Position2D.position.x
var speed = 15
var verschil
var Start = false

func _on_Area2D_area_entered(area):
	$Hand.position.x = Spawn
	

func _on_Timer_timeout():
	Start = true

func _process(delta):
	if Start:
		verschil = $Hand.position.x - Spawn
		$Hand.position.x += speed * delta
		if Input.is_action_just_pressed("ui_up"):
			if verschil < 20:
				$Hand.position.x -= verschil
			else:
				$Hand.position.x -= speed

