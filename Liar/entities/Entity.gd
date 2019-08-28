extends KinematicBody2D

class_name Entity

signal died(entity)

export var speed = 100

var isDead : bool = false
var moveDirection : Vector2 = Vector2()

func _physics_process(delta):
	if not isDead:
		moveInputs()
		move()

func moveInputs():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var down = Input.is_action_pressed("ui_down")
	var up = Input.is_action_pressed("ui_up")
	
	moveDirection = Vector2(-int(left) + int(right), -int(up) + int (down))

func move():
	var dir = moveDirection.normalized() * speed
	move_and_slide(dir)