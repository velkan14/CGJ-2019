extends KinematicBody2D

signal died(entity)
signal following(target)
signal lost(target)


export var speed = 200

var isDead : bool = false
var following : bool = false
var target : KinematicBody2D
var moveDirection : Vector2 = Vector2()

func _physics_process(delta):
	if not isDead:
		moveInputs()
		move()
		
func moveInputs():
	if following:
		moveDirection = target.position - position

func move():
	var dir = moveDirection.normalized() * speed
	move_and_slide(dir)

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
