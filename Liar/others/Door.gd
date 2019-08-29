extends StaticBody2D

class_name Door

onready var anim : AnimationPlayer = $AnimationPlayer
onready var collision : CollisionShape2D = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
var opened : bool = false

func _ready():
	anim.play("idle")

func open():
	if not opened:
		anim.play("open")
		yield(anim, "animation_finished")
		collision.disabled = true
		opened = true

func close():
	if opened:
		anim.play("close")
		collision.disabled = false
		yield(anim, "animation_finished")
		opened = false

func trigger():
	if opened:
		close()
	else:
		open()
		