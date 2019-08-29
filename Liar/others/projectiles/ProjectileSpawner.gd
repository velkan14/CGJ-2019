extends Node2D

var projectile = preload("Projectile.tscn")
onready var cooldown_timer = $CooldownTimer
func _input(event):
	if event.is_action_pressed("attack") and owner.look_direction != Vector2():
		fire(owner.look_direction)

func fire(direction):
	if not cooldown_timer.is_stopped():
		return

	cooldown_timer.start()
	var new_bullet = projectile.instance()
	new_bullet.direction = direction
	add_child(new_bullet)
