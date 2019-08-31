extends Area2D

signal pressed

onready var sprite = $Sprite

func _on_PlateTrigger_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("pressed")
		sprite.frame = 6

func _on_PlateTrigger_body_exited(body):
	if body.is_in_group("player"):
		emit_signal("unpressed")
		sprite.frame = 5
		
