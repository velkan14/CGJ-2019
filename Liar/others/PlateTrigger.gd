extends Area2D

signal pressed

func _on_PlateTrigger_body_entered(body):
	emit_signal("pressed")