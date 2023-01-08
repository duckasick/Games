extends KinematicBody2D

var HP = 3


func _ready():
	$Label.text = str("HP: ", HP)
	$Nuke.visible = false

# Hitbox
func _on_Area2D_area_entered(area):
	if HP == 1:
		$Label.visible = false
		$Sprite.visible = false
		$"Sprite-0003".visible = false
		$Nuke.visible = true
		print("omaewamou")
		$AnimationPlayer.play("Boom")
		$Area2D.collision_layer = 16 #Dit is de death layer, zodat hitboxes niet meer werkt
	else: HP -= 1
	$Label.text = str("HP: ", HP)
	
func boom_finished():
	queue_free()
