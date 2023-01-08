extends RigidBody2D
# Gravity naar 0 gezet, geen mask, zodat ze elkaar niet raken




func _ready():
	$AnimatedSprite.playing = true  # zet animatie aan
	var mob_types = $AnimatedSprite.frames.get_animation_names()    #Maakt een array van alle animaties (walk, swim, fly), waar is frames voor?
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] # Kiest een animatie van de array

func _on_VisibilityNotifier2D_screen_exited():  # Regelt dat de mobs verdwijnen als ze van het scherm af zijn
	queue_free()
