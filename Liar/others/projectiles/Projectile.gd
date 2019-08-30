extends KinematicBody2D


var direction = Vector2()
export(float) var SPEED = 1000.0

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	var collision_info = move_and_slide(direction * SPEED)

func _on_HitBox_body_entered(body):
	if body.is_in_group("enemy"):
		#body.hit(0.5)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	print("EXIT")
	queue_free()
