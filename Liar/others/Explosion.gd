extends Sprite

signal exploded

func _ready():
	hide()

func explode():
	show()
	$Anim.play("Explosion")
	yield($Anim, "animation_finished")
	emit_signal("exploded")