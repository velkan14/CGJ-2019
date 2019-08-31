extends Entity

signal change_move(direction)

signal following(target)
signal lost(target)

var following : bool = false
var target : KinematicBody2D
var last_look_dir : Vector2 = Vector2()

func moveInputs():
	if following:
		moveDirection = target.position - position
		var look_dir = moveDirection.normalized()
		look_dir.x = int(round(look_dir.x))
		look_dir.y = int(round(look_dir.y))
		if last_look_dir != look_dir:
			emit_signal("change_move", look_dir)
		last_look_dir = look_dir

func _on_VisionArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		following = true
		emit_signal("following", body)


func _on_VisionArea_body_exited(body):
	if body.is_in_group("player"):
		target = null
		following = false
		moveDirection = Vector2()
		emit_signal("lost", body)

func _on_CollisionArea_body_entered(body):
	if body.is_in_group("player") and not isDead:
		body.take_damage(1)

