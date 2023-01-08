extends Node

var scale = 1

func _ready():
	Engine.time_scale = scale

func _process(delta):
	Engine.time_scale = scale


var scoreTile = 0
var StrafPTile = 0
var StrafGlobal = 0

