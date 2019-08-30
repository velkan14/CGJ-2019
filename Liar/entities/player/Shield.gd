extends Area2D

onready var collision : CollisionShape2D = $CollisionShape2D 
onready var shape : Polygon2D = $Polygon2D 
onready var timer : Timer = $Timer 
onready var cooldown_timer : Timer = $CooldownTimer 

func _ready():
	deactivate_shield()
	
func _input(event):
	if event.is_action_pressed("shield"):
		shield(owner.look_direction)

func shield(direction):
	if not cooldown_timer.is_stopped():
		return
	activate_shield()
	timer.start()
	yield(timer, "timeout")
	deactivate_shield()
	cooldown_timer.start()

func activate_shield():
	shape.show()
	collision.disabled = false

func deactivate_shield():
	shape.hide()
	collision.disabled = true