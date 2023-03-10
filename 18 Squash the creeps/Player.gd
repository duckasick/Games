extends KinematicBody

signal hit

export var speed = 14
export var jump_impulse = 20
export var bounce_impulse = 16
export var fall_acceleration = 75

var velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
#	XZ-plane is grond
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
#	Speel animatie sneller als je draait 
		$Pivot.look_at(translation + direction, Vector3.UP)
		$AnimationPlayer.playback_speed = 4
	else:
		$AnimationPlayer.playback_speed = 1

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Jumping
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y += jump_impulse

	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)

#	Kill check
	for index in range(get_slide_count()):
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			if Vector3.UP.dot(collision.normal) > 0.1:
				mob.squash()
				velocity.y = bounce_impulse
# 	Jump arc
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func _on_MobDetector_body_entered(_body):
	emit_signal("hit")
	queue_free()
