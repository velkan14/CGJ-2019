extends Area2D

const DamageSource = preload("res://entities/hit_box/DamageSource.gd")

func _on_area_entered(area):
	if not area is DamageSource:
		return
	owner.take_damage_from(area)

func set_active(value):
	$CollisionShape2D.disabled = not value
