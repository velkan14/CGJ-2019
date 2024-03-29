extends Entity

class_name Player

signal change_move(direction)

var lastMoveDirection : Vector2 = Vector2()


func moveInputs():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var down = Input.is_action_pressed("ui_down")
	var up = Input.is_action_pressed("ui_up")
	
	moveDirection = Vector2(-int(left) + int(right), -int(up) + int (down))
	
	if not moveDirection == Vector2():
		look_direction = moveDirection
	
	if lastMoveDirection != moveDirection:
		emit_signal("change_move", moveDirection)
	
	lastMoveDirection = moveDirection

func explode():
	stats.take_damage(10000)

func _process(delta):
	if isDead:
		get_tree().change_scene("res://Test.tscn")
