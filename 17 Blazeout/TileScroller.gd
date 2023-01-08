extends Node2D

const bulletKath = preload("res://TileScrollerTiles.tscn")
const bulletBath = preload("res://TileScrollerTilesACTIEF.tscn")		
var KleurHok
var array = [1, 2, 2, 2]
var bullet

func _ready():
	var bullet = bulletBath.instance()
	bullet.position = $Position2D.global_position


func _on_Timer_timeout():
	var KleurHok = array[randi() % array.size()]
	if KleurHok == 1:
		var bullet = bulletBath.instance()
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
	elif KleurHok == 2:
		var bullet = bulletKath.instance()
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position

func _process(delta):
	$RichTextLabel.text = str(AAA.scoreTile)
	$RichTextLabel2.text = str(AAA.StrafPTile)

func _on_StartTimer_timeout():
	$Timer.start()
