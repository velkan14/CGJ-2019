extends Motion


class_name OnGround

var speed = 0.0
var velocity = Vector2()

func handle_input(event):
	if event.is_action_pressed("ui_select"):
		emit_signal("finished", "jump")
	return .handle_input(event)
