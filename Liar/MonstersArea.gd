extends Area2D

signal all_enemies_died
signal enemy_died

var enemies : Array = []

func _on_EnemiesArea_body_entered(body):
	if body.is_in_group("enemy"):
		body.connect("died", self, "_on_died_enemy")
		enemies.append(body)

func _on_died_enemy(enemy):
	emit_signal("enemy_died", enemy)
	var all_dead = true
	for m in enemies:
		if m.isDead:
			continue
		else:
			all_dead = false
			break
	if all_dead:
		emit_signal("all_enemies_died")


func _on_EnemiesArea_body_exited(body):
	pass # Replace with function body.
