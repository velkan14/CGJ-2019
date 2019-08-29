extends KinematicBody2D

class_name Entity

signal died(entity)

onready var isShooting = false
onready var projectile = preload("res://others/Projectile.tscn") 

export var speed = 100

onready var collision : CollisionShape2D = $Collision

var health : float = 5.0
var isDead : bool = false
var moveDirection : Vector2 = Vector2()

func _physics_process(delta):
	var shoot = Input.is_action_pressed("attack")
	if shoot and !isShooting:
		startShooting()
	if not isDead:
		moveInputs()
		move()

func moveInputs():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var down = Input.is_action_pressed("ui_down")
	var up = Input.is_action_pressed("ui_up")
	
	moveDirection = Vector2(-int(left) + int(right), -int(up) + int (down))

func take_damage(amount : float):
	health -= amount
	health = max(0, health)
	if (health <= 0.0):
		isDead = true
		emit_signal("died", self)
	

func move():
	var dir = moveDirection.normalized() * speed
	move_and_slide(dir)
	if moveDirection.y > 0 & $Rotation.rotation != 0:
		$Rotation.rotation_degrees = 0
	if moveDirection.y < 0 & $Rotation.rotation != 180:
		$Rotation.rotation_degrees = 180
	if moveDirection.x > 0 & $Rotation.rotation != 90:
		$Rotation.rotation_degrees = 90
	if moveDirection.x < 0 & $Rotation.rotation != -90:
		$Rotation.rotation_degrees = -90


func startShooting():
	var newProjectile = add_child(projectile.instance())
	$Projectile.position = $ShootingPosition.position
