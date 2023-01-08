extends Node #Node, want 2D functionaliteit is niet nodig

export(PackedScene) var mob_scene
var score

func _ready():
	randomize()

func _on_Playah_hit():
	$Scoretimer.stop()
	$Mobtimer.stop()
	$Hud.show_game_over()


func new_game():
	score = 0
	$Playah.start($Spawn.position)
	$Starttimer.start()
	print("begin")
	$Hud.update_score(score)
	$Hud.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")


func _on_Scoretimer_timeout():
	score += 1
	$Hud/Score.update_score(score)

func _on_Starttimer_timeout():
	$Mobtimer.start()
	$Scoretimer.start()
	print("start")




func _on_Mobtimer_timeout():    #Dit moet ik ff uitzoeken
	var mob = mob_scene.instance()
	
	var mob_spawn_location = $Path2D/PathFollow2D
	mob_spawn_location.offset = randi()
	
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_Hud_startgame():
	new_game()
