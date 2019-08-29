extends Entity

signal following(target)
signal lost(target)

var following : bool = false
var target : KinematicBody2D

func moveInputs():
	if following:
		moveDirection = target.position - position


func _on_VisionArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		following = true
		emit_signal("following", body)


func _on_VisionArea_body_exited(body):
	target = null
	following = false
	moveDirection = Vector2()
	emit_signal("lost", body)


func _on_CollisionArea_body_entered(body):
	if body.is_in_group("player"):
		pass
#		body.hit(0.5)
