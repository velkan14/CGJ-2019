extends KinematicBody2D

class_name Entity

signal died(entity)

export var speed = 250

onready var collision : CollisionShape2D = $Collision
onready var stats : Stats = $Stats

var isDead : bool = false
var moveDirection : Vector2 = Vector2()
var look_direction : Vector2 = Vector2()

func _ready():
	stats.connect("health_depleted", self, "_on_health_depleted")

func _physics_process(delta):
	if not isDead:
		moveInputs()
		move()

func moveInputs():
	pass

func take_damage(amount : float):
	stats.take_damage(amount)

func move():
	var dir = moveDirection.normalized() * speed
	move_and_slide(dir)
	
func _on_health_depleted():
	isDead = true
	emit_signal("died")
