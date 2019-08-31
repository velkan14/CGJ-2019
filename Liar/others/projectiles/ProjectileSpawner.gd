extends Node2D

onready var anim_shoot : AnimationPlayer = get_node("../SpriteAnim/AnimationShoot")

var projectile = preload("Projectile.tscn")
onready var cooldown_timer = $CooldownTimer
func _input(event):
	if event.is_action_pressed("attack") and owner.look_direction != Vector2():
		fire(owner.look_direction)

func fire(direction):
	if not cooldown_timer.is_stopped():
		return
	anim_shoot.play("shoot")
	yield(anim_shoot, "animation_finished")
	cooldown_timer.start()
	var new_bullet = projectile.instance()
	new_bullet.direction = owner.look_direction
	add_child(new_bullet)
	anim_shoot.play_backwards("shoot")
	yield(anim_shoot, "animation_finished")
	anim_shoot.play_backwards("idle")
	
